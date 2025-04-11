extends CharacterBody2D
class_name Player

@export var speed = 800
@export var knockback_strength = 200
@onready var animation_player = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var audio_player = $AudioStreamPlayer2D
var dir: String = ""
var is_hurt: bool = false

func _ready() -> void:
	pass

func _process(_delta):
	if Input.is_action_just_pressed("attack") and not is_hurt:
		attack()

func attack():
	if dir == "right":
		animation_player.play("attack_right")
	elif dir == "left":
		animation_player.play("attack_left")
	elif dir == "up":
		animation_player.play("attack_up")
	else:
		animation_player.play("attack_down")

func _physics_process(_delta):
	# If the player is in the hurt state, continue applying knockback and ignore input.
	if is_hurt:
		move_and_slide()
		return

	# Otherwise, process normal movement input.
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	
	if not (animation_player.current_animation in ["attack_down", "attack_up", "attack_right", "attack_left", "hurt"]):
		if Input.is_action_pressed("down"):
			animation_player.play("walk_down")
			dir = "down"
		elif Input.is_action_pressed("up"):
			animation_player.play("walk_up")
			dir = "up"
		elif Input.is_action_pressed("right"):
			animation_player.play("walk_right")
			dir = "right"
		elif Input.is_action_pressed("left"):
			animation_player.play("walk_left")
			dir = "left"
		else:
			animation_player.stop()
	
	move_and_slide()

func _on_hit_box_area_entered(area: Area2D) -> void:
	var parent = area.get_parent()
	if area.name == "HitBox" and parent is EnemyBase:
		parent.take_damage(10, self.position)
	elif area.name == "HitBox" and parent is Dessert:
		parent.eaten()

# Updated take_damage function with knockback.
func take_damage(amount: int, source_position: Vector2) -> void:
	is_hurt = true
	animation_player.play("hurt")
	audio_player.play()
	State.hungre_take_damage(amount)
	
	var knockback_dir = (position - source_position).normalized()
	velocity = knockback_dir * knockback_strength
	
	await animation_player.animation_finished
	
	if State.hungre_health <= 0:
		get_tree().change_scene_to_packed(State.lose_screen_scene)
	else:
		is_hurt = false
