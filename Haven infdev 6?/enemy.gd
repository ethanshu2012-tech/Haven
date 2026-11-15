extends CharacterBody2D

# Movement & Jump Settings
@export var walk_speed: float = 140.0
@export var retreat_speed: float = 120.0
@export var rush_speed: float = 420.0
@export var jump_velocity: float = -150.0    
@export var jump_on_rush: bool = true         
@export var jump_over_walls: bool = true     
@onready var meanimation = $AnimatedSprite2D
# Distances & Timing
@export var trigger_range: float = 110.0
@export var hit_range: float = 45.0
@export var retreat_time: float = 0.45
@export var rush_time: float = 0.35
@export var cooldown_time: float = 0.8
@export var attack_damage: int = 10
var hp = 2
@export var sprite: Node2D

enum State { CHASE, RETREAT, RUSH, COOLDOWN }
var current_state: State = State.CHASE

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var player: Node2D = null
var state_timer: float = 0.0
var rush_direction: float = 1.0
var has_dealt_damage: bool = false

const ENEMY = preload("res://Enemy.tscn")
func _ready() -> void:
	add_to_group("Enemy")
	
	#if not GlobalData.cloned:
		#GlobalData.cloned = true
		#var new = ENEMY.instantiate()
		#GlobalData.world.add_child(new)
		#print("aa")
		#new = ENEMY.instantiate()
		#GlobalData.world.add_child(new)
		#print("aa")
		#new = ENEMY.instantiate()
		#GlobalData.world.add_child(new)
		#print("aa")
		#new = ENEMY.instantiate()
		#GlobalData.world.add_child(new)
		#print("aa")
		#GlobalData.enemies = GlobalData.enemies + 4
	meanimation.play("Right")
	
	
func _physics_process(delta: float) -> void:
	
	if player == null:
		player = get_tree().get_first_node_in_group("player")
	if player == null:
		player = get_tree().current_scene.find_child("Player", true, false)

	if not is_on_floor():
		velocity.y += gravity * delta

	if player == null:
		velocity.x = 0.0
		move_and_slide()
		return

	var distance_x: float = player.global_position.x - global_position.x
	var direction_to_player: float = sign(distance_x)

	match current_state:
		State.CHASE:
			face_direction(direction_to_player)
			
			if abs(distance_x) > trigger_range:
				velocity.x = direction_to_player * walk_speed
				
				if jump_over_walls and is_on_floor():
					var player_is_higher: bool = player.global_position.y < global_position.y - 25.0
					if is_on_wall() or player_is_higher:
						velocity.y = jump_velocity
			else:
				current_state = State.RETREAT
				state_timer = retreat_time

		State.RETREAT:
			face_direction(direction_to_player)
			velocity.x = -direction_to_player * retreat_speed
			
			state_timer -= delta
			if state_timer <= 0:
				rush_direction = direction_to_player if direction_to_player != 0 else 1.0
				has_dealt_damage = false
				current_state = State.RUSH
				state_timer = rush_time
				
				if jump_on_rush and is_on_floor():
					velocity.y = jump_velocity

		State.RUSH:
			face_direction(rush_direction)
			velocity.x = rush_direction * rush_speed
			
			if not has_dealt_damage and abs(distance_x) <= hit_range and abs(player.global_position.y - global_position.y) < 50:
				has_dealt_damage = true
				if player.has_method("take_damage"):
					player.take_damage(attack_damage)

			state_timer -= delta
			if state_timer <= 0:
				current_state = State.COOLDOWN
				state_timer = cooldown_time

		State.COOLDOWN:
			velocity.x = move_toward(velocity.x, 0, walk_speed * 2 * delta)
			
			state_timer -= delta
			if state_timer <= 0:
				current_state = State.CHASE

	move_and_slide()

func takedamage() -> void:
	hp = hp - 1
	meanimation.play("rightinjure")
	if hp == 0:
		queue_free()
	
	
		
	
	

func face_direction(dir: float) -> void:
	if sprite != null and dir != 0:
		sprite.flip_h = dir < 0



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Bullet"):
		takedamage()
		print("took")
		queue_free()
		body.queue_free()
	if body.is_in_group("Player"):
		GlobalData.restart()
		
