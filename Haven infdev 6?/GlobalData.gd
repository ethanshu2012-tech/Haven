extends Node

@onready var world = self
@onready var player = %"../Node2D/Player"
var cloned = false
var enemies = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
func restart() -> void:
	get_tree().reload_current_scene()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
