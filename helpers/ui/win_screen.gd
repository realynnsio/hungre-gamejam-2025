extends Node2D

@export var next_scene: PackedScene = preload("res://helpers/ui/main_menu.tscn")

func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_play_again_pressed() -> void:
	State.reset_state()
	State.has_finished_game = true
	State.menu_illust = load("res://assets/cgs/main_menu2.png")
	get_tree().change_scene_to_packed(next_scene)
