extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_try_again_pressed() -> void:
	State.hungre_try_again()
	get_tree().change_scene_to_packed(State.tutorial_scene)


func _on_quit_pressed() -> void:
	get_tree().quit()
