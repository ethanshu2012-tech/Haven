extends CharacterBody2D

@onready var main = $main_scene
const SPEED = 350
const JUMP_VELOCITY = -900
const direction = 4


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	if direction and main.rightwallchar23 == false:
		velocity.x = (direction * SPEED)
		if is_on_wall():
			velocity.x = -(direction * SPEED)
			var rightwallchar23 = true
	else:
		velocity.x = -(direction * SPEED)

	move_and_slide()
