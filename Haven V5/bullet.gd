extends RigidBody2D

@export var speed: float = 800.0
@export var damage: int = 20
@export var lifetime: float = 3.0

func _ready() -> void:
	# 1. Connect collision signal automatically
	body_entered.connect(_on_body_entered)
	
	# 2. Launch the bullet forward based on its rotation
	linear_velocity = Vector2.RIGHT.rotated(rotation) * speed
	
	# 3. Delete the bullet after a few seconds so it doesn't lag the game
	await get_tree().create_timer(lifetime).timeout
	queue_free()

func _on_body_entered(body: Node) -> void:
	# Deal damage if the hit object (like your Enemy) has a take_damage function
	if body.has_method("take_damage"):
		body.take_damage(damage)
	
	# Destroy bullet on impact
	queue_free()
