extends Label

@onready var score_label = $"."

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	score_label.text = " Score\n" + str(State.score)
