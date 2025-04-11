extends Node2D

@export var dialogue_start: String = "start"
@onready var animation_player = $AnimationPlayer
@export var resource: DialogueResource = preload("res://story/test.dialogue")
@onready var background = $Control/BG
@onready var music_player = $MusicPlayer
@onready var sfx_player = $SFXPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DialogueManager.show_dialogue_balloon(resource, dialogue_start)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func change_icon(path):
	State.icon = load(path)

func change_room():
	animation_player.play_backwards("bg_show")
	await animation_player.animation_finished
	music_stop()
	await get_tree().process_frame
	get_tree().change_scene_to_packed(State.tutorial_scene)

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

# SFX methods
func sfx_change(sfx_path):
	sfx_player.stream = load(sfx_path)
func sfx_start(): 
	sfx_player.play()
func sfx_start_path(sfx_path):
	sfx_change(sfx_path)
	sfx_start()
func sfx_stop():
	sfx_player.stop()
