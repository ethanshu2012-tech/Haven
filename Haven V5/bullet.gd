extends CharacterBody2D

@export var speed: float = 800.0
@export var damage: int = 20
@export var lifetime: float = 3.0
var targetposition

func _ready() -> void:
	pass
	


	
func _on_body_entered(body: Node) -> void:
	# Deal damage if the hit object (like your Enemy) has a take_damage function
	if body.has_method("take_damage"):
		body.take_damage(damage)
	
	# Destroy bullet on impact
	queue_free()
