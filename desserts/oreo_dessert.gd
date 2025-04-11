extends AnimatedSprite2D
class_name Dessert

@onready var audio = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func eaten():
	State.eat_oreo.emit()
	State.has_cat = false
	modulate.a = 0
	audio.play()
	await audio.finished
	queue_free()

func _on_hit_box_body_entered(body: Node2D) -> void:
	if body.name == "Hungre":
		eaten()
