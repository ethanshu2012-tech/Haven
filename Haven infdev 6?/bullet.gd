extends CharacterBody2D
var bounces = 5
@export var speed: float = 800.0
@export var damage: int = 20
@export var lifetime: float = 3.0
var targetposition
@export var Theenemy = CharacterBody2D
var JUMP_VELOCITY: int = 800
func _ready() -> void:
	add_to_group("Bullet")
	pass
	


func _physics_process(delta: float) -> void:
	velocity = targetposition * speed
	if not is_on_floor():
		velocity += get_gravity() * delta
	if is_on_floor():
		velocity.y = JUMP_VELOCITY
	var collision = move_and_collide(delta * speed * targetposition)
	if collision:
		bounces = bounces - 1
		targetposition = targetposition.bounce(collision.get_normal())
		if bounces == 0:
			queue_free()
	
