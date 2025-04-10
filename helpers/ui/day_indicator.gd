extends VBoxContainer

@onready var day_label = $HBoxContainer/Day
@onready var icon = $HBoxContainer/Icon
@onready var location_label = $Location

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	day_label.text = State.day
	location_label.text = State.location
	icon.texture = State.icon
