extends Label

@onready var score_label = $"."
@onready var animation = $AnimationPlayer
@onready var audio = $AudioStreamPlayer

func _ready() -> void:
	State.score_add.connect(_score_add)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	score_label.text = " Score\n" + str(State.score)

func _score_add():
	audio.play()
	animation.play("score_add")
