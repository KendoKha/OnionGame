extends CharacterBody2D

const DIALOG := ["¿Te importa? \nEstoy esperando a un amigo", 
				 "Tu no eres una cebolla, ¿verdad?"]

var interactive := false
var index := 0

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if interactive and event.is_action_pressed("Interact"):
		%TextLabel.visible = true
		%interactive_button.visible = false
		
		if index <= DIALOG.size()-1: 
			%TextLabel.text = DIALOG[index]
			index+=1
		else:
			index -= 1
			%TextLabel.visible = false
			%interactive_button.visible = true

func _on_talk_area_area_entered(area: Area2D) -> void:
	interactive = true
	%interactive_button.visible = true

func _on_talk_area_area_exited(area: Area2D) -> void:
	interactive = false
	%interactive_button.visible = false
