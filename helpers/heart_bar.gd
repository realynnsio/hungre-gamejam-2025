extends HBoxContainer

var heart_full = preload("res://assets/sprites/heart_full.png")
var heart_empty = preload("res://assets/sprites/heart_empty.png")
var heart_half = preload("res://assets/sprites/heart_partial.png")
var health

#func _ready() -> void:
	#State.hungre_hurt.connect(update_health)
	#
#func update_health(value):
	#value = value/10
	#for i in range(3):
		#if value > i * 2 + 1:
			#get_node(str(i+1)).texture = heart_full
		#elif value > i * 2:
			#get_node(str(i+1)).texture = heart_half
		#else:
			#get_node(str(i+1)).texture = heart_empty

func _process(delta: float) -> void:
	health = State.hungre_health
	var value = health/10
	for i in range(3):
		if value > i * 2 + 1:
			get_node(str(i+1)).texture = heart_full
		elif value > i * 2:
			get_node(str(i+1)).texture = heart_half
		else:
			get_node(str(i+1)).texture = heart_empty
