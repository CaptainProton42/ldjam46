extends Node2D

onready var animation_player = get_node("AnimationPlayer")
onready var label = get_node("Label")
onready var label_submessage = get_node("Label2")

func show_message(message, submessage = ""):
	label.text = message
	label_submessage.text = submessage
	animation_player.play("display")


func fade():
	animation_player.play("fade")