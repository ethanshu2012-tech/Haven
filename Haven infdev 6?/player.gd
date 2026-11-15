extends CharacterBody2D

const SPEED = 500.0
const JUMP_VELOCITY = -650.0
var canshoot = true
@onready var _animated_sprite = $AnimatedSprite2D
@onready var _animated_gun = $AnimatedSprite2D2
@onready var sprite = $Sprite # Reference to the Sprite node
func _ready() -> void:
	add_to_group("Player")

var fire_cadence = 0.67
var fire_cooldown = 0.0




func _process(delta):
	if Input.is_action_pressed("right"):
		_animated_sprite.play("Right")
		_animated_gun.play("right")
	elif Input.is_action_pressed("left"):
		_animated_sprite.play("Left")
		_animated_gun.play("left")
	if fire_cooldown <= 0:
		canshoot = true
	fire_cooldown -= delta
	if GlobalData.enemies == 0:
		_animated_sprite.play("win")
		

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT && canshoot:
			get_node("AnimatedSprite2D2").shoot()
			canshoot = false
			fire_cooldown = fire_cadence
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	# Handle jump.
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
