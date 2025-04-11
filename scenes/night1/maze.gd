extends Node2D

@onready var animation_player = $AnimationPlayer
@onready var music_player = $MusicPlayer
@export var next_scene: PackedScene = preload("res://scenes/test_scene.tscn")

@onready var sfx_player = $SFXPlayer
@onready var hungre = $Game/Hungre

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	State.has_key = false
	State.change_room.connect(change_room)
	animation_player.play("bg_show")
	await animation_player.animation_finished
	music_start()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func pause_game():
	hungre.set_physics_process(false)
	hungre.set_process(false)

func resume_game():
	hungre.set_physics_process(true)
	hungre.set_process(true)

func change_room():
	animation_player.play_backwards("bg_show")
	await animation_player.animation_finished
	music_stop()
	get_tree().change_scene_to_packed(next_scene)

func bg_show():
	animation_player.play("bg_show")
	await animation_player.animation_finished
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
