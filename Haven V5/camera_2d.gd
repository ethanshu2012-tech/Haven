extends Camera2D
@export var follow_speed: float = 5.0
@export var target: NodePath
func _process(delta):
	if target:
		var target_pos = get_node(target).global_position
		global_position = lerp(global_position, target_pos, follow_speed * delta)
