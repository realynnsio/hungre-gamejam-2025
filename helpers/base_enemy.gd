extends StaticBody2D
class_name EnemyBase

@export var health: int = 30
@onready var animation_player = $AnimationPlayer
@onready var sprite = $Sprite2D
@export var spritesheet = preload("res://assets/sprites/mob_cream.png")

func _ready() -> void:
	sprite.texture = spritesheet
	animation_player.play("walk_right")

func take_damage(amount: int) -> void:
	animation_player.play("hurt")
	health -= amount
	if health <= 0:
		await animation_player.animation_finished
		queue_free()

func _physics_process(delta: float) -> void:
	if animation_player.current_animation != "hurt":
		animation_player.play("walk_right")

func _on_hit_box_area_entered(area: Area2D) -> void:
	var parent = area.get_parent()
	if area.name == "HurtBox" and parent is Player:
		parent.take_damage(10)
