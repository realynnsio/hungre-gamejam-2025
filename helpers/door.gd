extends Area2D

@export var dialogue_start: String = "no_key"
@export var resource_path: String = "res://story/night1/night1.dialogue"
@onready var animation = $AnimationPlayer
#@export var next_scene: PackedScene = preload("res://scenes/test_scene.tscn")
var resource: DialogueResource
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	resource = load(resource_path)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Hungre":
		if State.has_key:
			animation.play("open")
			await animation.animation_finished
			State.change_room.emit()
			#animation.play("transition")
			#await animation.animation_finished
			#get_tree().change_scene_to_packed(next_scene)
		else:
			DialogueManager.show_dialogue_balloon(resource, dialogue_start)
