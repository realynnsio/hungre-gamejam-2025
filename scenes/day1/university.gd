extends Node2D

@export var dialogue_start: String = "start"
@onready var animation_player = %AnimationPlayer
@export var resource = preload("res://story/test.dialogue")
@onready var background = $Control/BG
@onready var music_player = $MusicPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DialogueManager.connect("dialogue_ended", _on_dialogue_ended)
	DialogueManager.show_dialogue_balloon(resource, dialogue_start)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_dialogue_ended(args=[]) :
	if not args:
		queue_free()
	else:
		var scene_path = "res://scenes/%s.tscn" % args[0]
		get_tree().change_scene_to_file(scene_path) 

# BG Methods
func bg_change(bg_path):
	background.texture = load(bg_path)

func bg_show():
	animation_player.play("bg_show")
	await animation_player.animation_finished

func bg_show_path(bg_path):
	bg_change(bg_path)
	bg_show()

func bg_hide():
	animation_player.play_backwards("bg_show")
	await animation_player.animation_finished

# Music methods
func music_change(music_path):
	music_player.stream = load(music_path)

func music_start(): 
	music_player.play()

func music_start_path(music_path):
	music_change(music_path)
	music_start()

func music_stop():
	music_player.stop()
