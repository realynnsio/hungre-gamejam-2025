extends Node

# Preload scenes
var tutorial_scene: PackedScene = preload("res://scenes/night1/tutorial.tscn")
var lose_screen_scene: PackedScene = preload("res://helpers/ui/lose_screen.tscn")

# Wheel spin variables
var speed = 0.8
var choice = ""

# UI Variables
var day = "Day ???"
var location = "?????"
var icon = preload("res://assets/sprites/sun.png")

# Signals
signal hungre_hurt
signal mitch_hunger_change
signal change_room

# Player stats
var mitch_stomach = 40

# Level
var hungre_health = 60
var has_key = false
var skip_cat = 0
var hungre_mad = false
var finished_intro = false

# Relationship stats
var michelle_affection = 0
var doc_friendliness = 0
var cat_friendliness = 0

var has_michelle = true
var has_doc = true
var has_cat = true

# Route bools
var go_with_michelle = false

func hungre_take_damage(value):
	hungre_health -= value
	hungre_hurt.emit(hungre_health)

func mitch_eat(value):
	mitch_stomach += value
	mitch_hunger_change.emit(mitch_stomach)

func hungre_try_again():
	hungre_health = 60
	has_key = false
	skip_cat = 0
	hungre_mad = false

func change_scene_to_node(node):
	var tree = get_tree()
	var cur_scene = tree.get_current_scene()
	tree.get_root().add_child(node)
	tree.set_current_scene(node)
	tree.reload_current_scene()
	
	
