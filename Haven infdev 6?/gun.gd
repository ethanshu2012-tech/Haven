extends AnimatedSprite2D
const BULLET = preload("res://bullet(withplaceholder).tscn")
@onready var marker2d = $Marker2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#i wrote this if myself
	#thats why it makes the error  Attempt to call function 'is_playing' in base 'null instance' on a null instance.
	#if $AnimatedSprite2D2.playingsmthidkwhatfunction == "right":
	#	look_at(get_global_mouse_position())
	#else:
	#	look_at(-1#(flipped)*get_global_mouse_position())
	look_at(get_global_mouse_position())
	pass
func shoot() -> void:
	var new_bullet = BULLET.instantiate()
	new_bullet.position = marker2d.global_position
	new_bullet.targetposition = (get_global_mouse_position() - marker2d.global_position).normalized()
	GlobalData.world.add_child(new_bullet)
