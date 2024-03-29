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
var attack_ip = false #attack in prog



enum {IDLE, WALK}
var state = IDLE

@onready var animationTree = $AnimationTree
@onready var state_machine = animationTree["parameters/playback"]

var blend_position : Vector2 = Vector2.ZERO
var blend_pos_paths = [
	"parameters/idle/idle_BlendSpace2D/blend_position",
	"parameters/walk/Walk_BlendSpace2D/blend_position"
]
var animTree_state_keys = [
	"idle",
	"walk"
]

# Member variable to keep track of the current max speed, including any sprint modifications
var current_max_speed = MAX_SPEED

func _physics_process(delta):
	move(delta)
	enemy_attack()
	animate()
	update_health()
	if health <= 0:
		player_alive = false # need end screen or somthing 
		health = 0 
		print("player has died")
		

func move(delta):
	var input_vector = Input.get_vector("Left", "Right", "Up", "Down")
	current_max_speed = MAX_SPEED  # Reset to default at each frame
	if Input.is_action_just_pressed("Shoot_Toggle"):
		shooting_enabled = not shooting_enabled
		
	if Input.is_action_pressed("Sprint"):
		current_max_speed *= SPRINT_MULTIPLIER  # Adjust for sprinting

	if input_vector == Vector2.ZERO:
		state = IDLE
		apply_friction(FRICTION * delta)
	
				
	# TODO make states for pistol and shotgun using this format 	
	#if input_vector == Vector2.ZERO and shooting_enabled == true:
	#	state = IDLE_pistol
	#	apply_friction(FRICTION * delta)
	
	#if input_vector == Vector2.ZERO and shooting_enabled == true:
	#	state = IDLE_attack
	#	apply_friction(FRICTION * delta)
	
	#TODO this needs to change for Walking with weapons 
	
	else:
		state = WALK
		apply_movement(input_vector, delta)
	move_and_collide(velocity * delta)

func apply_movement(input_vector, delta) -> void:
	var acceleration = ACCELERATION
	if Input.is_action_pressed("Sprint"):
		acceleration *= SPRINT_MULTIPLIER
		# Scale blend_position by the sprint multiplier to reflect increased speed
		blend_position = input_vector.normalized() * SPRINT_MULTIPLIER
	else:
		blend_position = input_vector.normalized()
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
