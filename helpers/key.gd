extends StaticBody2D

@onready var audio = $AudioStreamPlayer
@onready var sprite = $AnimatedSprite2D
@onready var collision = $CollisionShape2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	collision.disabled = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Hungre":
		State.has_key = true
		sprite.hide()
		audio.play()
		await audio.finished
		queue_free()
