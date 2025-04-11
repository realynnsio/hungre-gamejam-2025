extends Node2D

@export var next_scene: PackedScene = preload("res://scenes/day1/university_intro.tscn")
@onready var audio = $AudioStreamPlayer
@onready var illustration = $CanvasLayer/MainMenuIllust
@onready var animation = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation.play("bg_show")
	if !State.has_finished_game:
		audio.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	illustration.texture = State.menu_illust

func _on_play_pressed() -> void:
	animation.play_backwards("bg_show")
	await animation.animation_finished
	get_tree().change_scene_to_packed(next_scene)

func _on_quit_pressed() -> void:
	get_tree().quit()
