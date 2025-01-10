extends Node
class_name DialogComponent

@export var _owner :CharacterBody2D
@onready var text_label = owner.find_child("TextLabel")
@onready var interactive_button = owner.find_child("InteractiveButton")
@onready var talk_area = owner.find_child("TalkArea") as Area2D
var index := 0
var interactive := false

func _input(event: InputEvent) -> void:
	if interactive and event.is_action_pressed("Interact"):
		text_label.visible = true
		interactive_button.visible = false
		
		if index <= _owner.DIALOG.size() -1:
			text_label.text = _owner.DIALOG[index]
			index += 1
			get_tree().paused = true
		else:
			index -= 1
			text_label.visible = false
			interactive_button.visible = true
			get_tree().paused = false


func _on_talk_area_area_entered(area: Area2D) -> void:
	interactive = true
	interactive_button.visible = true

func _on_talk_area_area_exited(area: Area2D) -> void:
	interactive = false
	interactive_button.visible = false
