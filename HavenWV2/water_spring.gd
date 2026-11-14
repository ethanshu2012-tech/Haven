extends Node2D

var velocity = 0

var force = 0

var height = 0

var target_height = 0

func water_update(spring_constant, dampening):
	
	height = position.y
	
	var x = height - target_height
	
	var loss = -dampening * velocity
	
	force = -spring_constant * x + loss
	
	velocity += force
	
	position.y += velocity
	pass

func initialize():
	height = position.y
	velocity = 0
