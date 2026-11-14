extends Node2D

@onready var animated_sprite = $AnimatedSprite2D

var max_hp: int = 10
var current_hp: int = 10

func _on_enemy_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		take_damage(1)
		current_hp = current_hp - 1
func take_damage(amount: int) -> void:
	current_hp -= amount
	if current_hp <= 0:
		animated_sprite.play(9)

	# Change sprite based on HP
	update_sprite()
func update_sprite() -> void:
	var frame_index = max_hp - current_hp + 1  # 10 = full health, 1 = dead
	if frame_index <= 10 and frame_index >= 1:
		animated_sprite.play("10")  # or your animation name
		animated_sprite.frame = frame_index  # 10 = full, 1 = low
