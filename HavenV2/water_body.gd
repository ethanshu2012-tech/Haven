extends Node2D

@export var k = 0.015
@export var d = 0.0
@export var spread = 0.0002

var springs =[]

func _ready():
	for i in get_children():
		springs.append(i)
		i. initialize()

func _physics_process(delta):
	for i in springs:
		i.water_update(k,d)
	
	var left_deltas = []
	var right_deltas = []
	
	for i in range (springs.size()):
		left_deltas.append(0)
		right_deltas.append(0)
		pass
	for i in range(springs.size()):
		if i > 0:
			left_deltas[i] = spread * (springs[i].height - springs[i-1].height)
			springs[i-1].velocity += left_deltas[i]
		if i < springs.size()-1:
			right_deltas[i] = spread * (springs[i].height - springs[+1].height)
