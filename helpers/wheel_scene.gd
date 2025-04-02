extends Node2D

@onready var wheel = $WheelBase/Wheel
@onready var needle = $NeedleSprite/Needle
@onready var animation_player = $AnimationPlayer
@onready var audio_player = $AudioStreamPlayer

@export var purple_text: String = "Purple"
@export var green_text: String = "Green"
@export var yellow_text: String = "Yellow"

@onready var purple_label: RichTextLabel = %PurpleLabel
@onready var green_label: RichTextLabel = %GreenLabel
@onready var yellow_label: RichTextLabel = %YellowLabel

func enter_anim():
	animation_player.play("enter")
	await animation_player.animation_finished
	start_spin()
	
func start_spin():
	audio_player.play()
	animation_player.speed_scale = State.speed
	animation_player.play("spin")
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	purple_label.text = "[center]" + purple_text + "[/center]"
	green_label.text = "[center]" + green_text + "[/center]"
	yellow_label.text = "[center]" + yellow_text + "[/center]"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	var valid = false
	
	if event is InputEventMouseButton and event.pressed:
		valid = true
	elif event is InputEventKey and event.pressed:
		if event.keycode == KEY_SPACE or event.keycode == KEY_ENTER:
			valid = true
	
	if valid:
		animation_player.pause()
		audio_player.stop()
		audio_player.stream = load("res://assets/sounds/spin_complete.wav")
		audio_player.play()
		
		await get_tree().process_frame
		if needle.has_overlapping_areas():
			if needle.get_overlapping_areas():
				var area = needle.get_overlapping_areas()[0]
				if area.name == "Purple":
					State.choice = "purple"
					animation_player.play("purple_select")
					await animation_player.animation_finished
				elif area.name == "Green":
					State.choice = "green"
					animation_player.play("green_select")
				else:
					State.choice = "yellow"
					animation_player.play("yellow_select")
				
		await get_tree().create_timer(1.0).timeout
		queue_free()
