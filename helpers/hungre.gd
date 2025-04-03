extends CharacterBody2D

@export var speed = 400  # speed in pixels/sec
@onready var animation_player = $AnimationPlayer
var dir: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("attack"):
		attack()

func attack():
	animation_player.play("attack_down")

func _physics_process(delta):
	
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	
	if animation_player.current_animation != "attack_down":
		if Input.is_action_pressed("down"):
			animation_player.play("walk_down")
		else:
			animation_player.play("idle")
	
		move_and_slide()


func _on_hit_box_area_entered(area: Area2D) -> void:
	var parent = area.get_parent()
	print(parent.name)
	if parent is EnemyBase:
		parent.take_damage(10)
