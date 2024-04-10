## Description: Character script for handling movement and animation.
## Author: Seth Daniels, Nico Gatapia, Jacob Horton, Elijah Toliver, Gilbert Vandegrift
## Date Created: March 10, 2024
## Date Modified: March 31, 2024
## Version: Development
## Godot Version: 4.2.1
## License: MIT License

extends CharacterBody2D

const ACCELERATION = 600
const FRICTION = 600
const MAX_SPEED = 150
const SPRINT_MULTIPLIER = 1.5
var shooting_enabled = false

var enemy_inattack_range = false
var enemy_attack_cooldown = true
var health = 100
var player_alive = true
var attack_ip = false #attack in progress

enum {IDLE, WALK, IDLE_PISTOL, WALK_PISTOL, SHOOT_PISTOL, IDLE_SHOTGUN, WALK_SHOTGUN, SHOOT_SHOTGUN}
var state = IDLE

@onready var animationTree = $AnimationTree
@onready var state_machine = animationTree["parameters/playback"]

var blend_position : Vector2 = Vector2.ZERO
var blend_pos_paths = [
	"parameters/idle/idle_BlendSpace2D/blend_position",
	"parameters/walk/Walk_BlendSpace2D/blend_position",
	"parameters/idle_pistol/idle_pistol_BlendSpace2D/blend_position",
	"parameters/walk_pistol/Walk_pistol_BlendSpace2D/blend_position",
	"parameters/shoot_pistol/Shoot_pistol_BlendSpace2D/blend_position",
	"parameters/idle_shotgun/idle_shotgun_BlendSpace2D/blend_position",
	"parameters/walk_shotgun/Walk_shotgun_BlendSpace2D/blend_position",
	"parameters/shoot_shotgun/Shoot_shotgun_BlendSpace2D/blend_position"
]

var animTree_state_keys = [
	"idle",
	"walk",
	"idle_pistol",
	"walk_pistol",
	"shoot_pistol",
	"idle_shotgun",
	"walk_shotgun",
	"shoot_shotgun"
]

var current_weapon = IDLE  # Starts with the character not holding a weapon
var last_weapon_state = IDLE_PISTOL  # Default last weapon state as pistol

var current_max_speed = MAX_SPEED

func _physics_process(delta):
	move(delta)
	enemy_attack()
	animate()
	update_health()
	if health <= 0:
		player_alive = false
		health = 0
		print("player has died")

func move(delta):
	var input_vector = Input.get_vector("Left", "Right", "Up", "Down")
	current_max_speed = MAX_SPEED  # Reset to default at each frame

	if Input.is_action_just_pressed("Swap_Weapon"):
		if shooting_enabled:
			if current_weapon in [IDLE_PISTOL, WALK_PISTOL, SHOOT_PISTOL]:
				current_weapon = IDLE_SHOTGUN  # Switch to shotgun
			else:
				current_weapon = IDLE_PISTOL  # Switch back to pistol

	if Input.is_action_just_pressed("Shoot_Toggle"):
		shooting_enabled = not shooting_enabled
		if shooting_enabled:
			current_weapon = last_weapon_state  # Enable last used weapon state
		else:
			last_weapon_state = current_weapon  # Save current weapon state
			current_weapon = IDLE  # Switch to unarmed state
		$"../Hud".visible = not $"../Hud".visible

	if Input.is_action_pressed("Sprint"):
		current_max_speed *= SPRINT_MULTIPLIER

	if input_vector == Vector2.ZERO:
		state = current_weapon  # Use the current weapon state for idle
		apply_friction(FRICTION * delta)
	else:
		state = current_weapon + 1  # Assumes walking state is always one index above idle state in enum
		apply_movement(input_vector, delta)

	move_and_collide(velocity * delta)

func apply_movement(input_vector, delta) -> void:
	var acceleration = ACCELERATION
	if Input.is_action_pressed("Sprint"):
		acceleration *= SPRINT_MULTIPLIER
	blend_position = input_vector.normalized() * (velocity.length() / MAX_SPEED)  # Reflect current velocity as blend position
	velocity += input_vector.normalized() * acceleration * delta
	velocity = velocity.limit_length(current_max_speed)

func apply_friction(amount) -> void:
	if velocity.length() > amount:
		velocity -= velocity.normalized() * amount
	else:
		velocity = Vector2.ZERO

func animate() -> void:
	state_machine.travel(animTree_state_keys[state])
	animationTree.set(blend_pos_paths[state], blend_position)

func player():
	pass

#checks of enemy entered the hitbox range 
func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_inattack_range = true

#checks of enemy left the hitbox range 
func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_inattack_range = false 
		
func enemy_attack():
	if enemy_inattack_range and enemy_attack_cooldown == true:
		health = health - 10
		enemy_attack_cooldown = false
		$attack_cooldown.start()
		print(health)
		
#cooldown between taking damage 
func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true 
	
func update_health():
	var healthbar = $healthbar
	healthbar.value = health
	
	if health >= 100:
		healthbar.visible = false 
	else:
		healthbar.visible = true
