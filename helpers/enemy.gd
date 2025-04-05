extends CharacterBody2D
class_name EnemyBase

@export var health: int = 30
@onready var animation_player = $AnimationPlayer
@onready var audio_player = $AudioStreamPlayer2D
@onready var sprite = $Sprite2D
@export var spritesheet = preload("res://assets/sprites/mob_cream.png")
@export var run_speed = 50
var speed = run_speed
var player = null
@onready var hitbox = $HitBox
var direction = Vector2.ZERO
@onready var detect_radius = $DetectRadius

func _ready() -> void:
	sprite.texture = spritesheet
	animation_player.play("walk_right")

func take_damage(amount: int, source_position: Vector2) -> void:
	animation_player.play("hurt")
	audio_player.play()
	health -= amount
	velocity = -direction * 100
	await animation_player.animation_finished  # Wait until "hurt" animation is done
	if health <= 0:
		queue_free()
	else:
		animation_player.play("walk_right")  # Reset to chase animation

func _physics_process(_delta: float) -> void:
	if animation_player.current_animation == "hurt":
		move_and_slide()
	else:
		velocity = Vector2.ZERO
		for being in detect_radius.get_overlapping_areas():
			if being.get_parent() is Player:
				player = being.get_parent()
		
		if player:
			direction = position.direction_to(player.position).normalized()
			velocity = direction * speed
		
			if direction.x > 0:
				sprite.scale.x = 1
			else:
				sprite.scale.x = -1
		
			animation_player.play("walk_right")	
			move_and_slide()
	
func _on_hit_box_area_entered(area: Area2D) -> void:
	var parent = area.get_parent()
	if area.name == "HurtBox" and parent is Player:
		parent.take_damage(10, self.position)

func _on_detect_radius_area_entered(area: Area2D) -> void:
	var parent = area.get_parent()
	if parent is Player:
		player = parent

func _on_detect_radius_area_exited(area: Area2D) -> void:
	var parent = area.get_parent()
	if parent is Player:
		player = null

func _on_hit_box_area_exited(area: Area2D) -> void:
	pass
