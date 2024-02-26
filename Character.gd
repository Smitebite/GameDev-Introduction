extends CharacterBody2D
const ACCELERATION = 800
const FRICTION = 500
const MAX_SPEED = 120

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

func _physics_process(delta):
	move(delta)
	animate()

func move(delta):
	var input_vector = Input.get_vector("Left", "Right", "Up", "Down")
	if input_vector == Vector2.ZERO:
		state = IDLE
		apply_friction(FRICTION * delta)
	else:
		state = WALK
		apply_movement(input_vector * ACCELERATION * delta)
		blend_position = input_vector
	move_and_slide()


func apply_movement(amount) -> void:
	velocity += amount
	velocity = velocity.limit_length(MAX_SPEED)

func apply_friction(amount) -> void:
	if velocity.length() > amount:
		velocity -= velocity.normalized() * amount
	else:
		velocity = Vector2.ZERO

func animate() -> void:
	state_machine.travel(animTree_state_keys[state])
	animationTree.set(blend_pos_paths[state],blend_position)
