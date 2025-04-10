extends Node2D

@export var dialogue_start: String = "start"
@onready var animation_player = $AnimationPlayer
@export var resource_path: String = "res://story/test.dialogue"
@onready var background = $Control/BG
@onready var music_player = $MusicPlayer
@export var next_scene_path = ""
@onready var sfx_player = $SFXPlayer
var spinning_wheel_scene = preload("res://helpers/wheel_scene.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var resource: DialogueResource = load(resource_path)
	DialogueManager.connect("dialogue_ended", _on_dialogue_ended)
	DialogueManager.show_dialogue_balloon(resource, dialogue_start)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_dialogue_ended(_args=[]) :
	if ResourceLoader.exists(next_scene_path):
		get_tree().change_scene_to_file(next_scene_path)
	else:
		queue_free()

# Wheel Functionality
func spawn_wheel(purple_text, green_text, yellow_text):
	await get_tree().create_timer(0.1).timeout
	var wheel_instance = spinning_wheel_scene.instantiate()  # Create an instance of the spinning wheel
	wheel_instance.purple_text = purple_text
	wheel_instance.green_text = green_text
	wheel_instance.yellow_text = yellow_text
	self.add_child(wheel_instance)
	wheel_instance.enter_anim()
	await wheel_instance.tree_exited  # Wait until the wheel instance is removed

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
