extends CharacterBody2D

@export var speed: float = 800.0
@export var damage: int = 20
@export var lifetime: float = 3.0
var targetposition
var JUMP_VELOCITY: int = 800
func _ready() -> void:
	pass
	


func _physics_process(delta: float) -> void:
	velocity = targetposition * speed
	if not is_on_floor():
		velocity += get_gravity() * delta
	if is_on_floor():
		velocity.y = JUMP_VELOCITY
	var collision = move_and_collide(delta * speed * targetposition)
	if collision:
		targetposition = targetposition.bounce(collision.get_normal())
	

func _on_body_entered(body: Node) -> void:
	
	
	# Deal damage if the hit object (like your Enemy) has a take_damage function
	if body.has_method("take_damage"):
		body.take_damage(damage)
	
	# Destroy bullet on impact
	queue_free()
