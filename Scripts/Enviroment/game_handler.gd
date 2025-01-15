extends Node2D

const SMALL_ONION = preload("res://Scenes/Characters/SmallOnion.tscn")
const BIG_ONION = preload("res://Scenes/Characters/BigOnion.tscn")

var glob_position

func _ready() -> void:
	SignalBus._transform.connect(_on_player__transform)

func _on_player__transform() -> void:
	if get_node("BigOnion"):
		print("big")
		glob_position = get_node("BigOnion").global_position
		get_node("BigOnion").queue_free()
		var small_onion = SMALL_ONION.instantiate()
		add_child(small_onion)
		small_onion.global_position = glob_position
		
	elif get_node("SmallOnion"):
		print("small")
		glob_position = get_node("SmallOnion").global_position
		get_node("SmallOnion").queue_free()
		var big_onion = BIG_ONION.instantiate()
		add_child(big_onion)
		big_onion.global_position = glob_position
	
