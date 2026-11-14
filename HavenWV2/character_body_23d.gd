extends CharacterBody2D

@onready var main = $main_scene
const SPEED = 350
const JUMP_VELOCITY = -900
var direction: Vector2
#ETHAN READ THIS
# I DIDNT KNOW WHAT TO DO
#SO I SEARCHED FOR A VID ONLINE
#AND TRIED TO ADAPT IT
#BUT IT DIDNT WORK
#SO I JUST COPIED IT BASICALLY WORD FOR WORD
#if u wanna know what vid it was
#https://www.youtube.com/watch?v=AHno-nd2F_I
#IF U UNDERSTAND HOW THIS WORKS
#PLEASE PLEASE TRY APPLY GRAVITY
func _ready() -> void:
	var scrnsze = get_viewport_rect().size
	direction = get_random_direction()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	

	# Handle jump.
	if is_on_floor():
		velocity.y = JUMP_VELOCITY
	var collision = move_and_collide(delta * SPEED * direction)
	if collision:
		direction = direction.bounce(collision.get_normal())
	
func get_random_direction() -> Vector2:
	var new_dir = Vector2()
	new_dir.x = [1, -1].pick_random()
	new_dir.y = randf_range(-1, 1)
	return new_dir.normalized()
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
