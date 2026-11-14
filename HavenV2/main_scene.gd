extends Node2D
@onready var char23 = $character_body_23d
var rightwallchar23 = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if char23.rightwallchar23 == true:
		rightwallchar23 = true
	pass
