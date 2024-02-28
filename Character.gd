extends CharacterBody2D

const ACCELERATION = 600
const FRICTION = 600
const MAX_SPEED = 150
const SPRINT_MULTIPLIER = 1.5

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
	animate()

func move(delta):
	var input_vector = Input.get_vector("Left", "Right", "Up", "Down")
	current_max_speed = MAX_SPEED  # Reset to default at each frame
	if Input.is_action_pressed("Sprint"):
		current_max_speed *= SPRINT_MULTIPLIER  # Adjust for sprinting

	if input_vector == Vector2.ZERO:
		state = IDLE
		apply_friction(FRICTION * delta)
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
