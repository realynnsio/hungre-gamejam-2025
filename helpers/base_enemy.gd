extends StaticBody2D
class_name EnemyBase

@export var health: int = 50
@onready var animation_player = $AnimationPlayer

func take_damage(amount: int) -> void:
	animation_player.play("hurt")
	health -= amount
	if health <= 0:
		queue_free()
