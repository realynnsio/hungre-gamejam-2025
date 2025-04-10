extends Control

@onready var pause_menu = $PauseCanvasLayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pause_menu.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			_on_pause_texture_button_pressed()

func _on_pause_texture_button_pressed() -> void:
	pause_menu.show()

func _on_resume_pressed() -> void:
	pause_menu.hide()
	var balloon = get_node_or_null("/root/Scene/ExampleBalloon")
	if balloon:
		if balloon.dialogue_label.is_typing:
			balloon.dialogue_label.skip_typing()
		else:
			# Only reset is_waiting_for_input if it’s not typing
			balloon.is_waiting_for_input = true

		balloon.balloon.grab_focus()
