extends Node2D

onready var animation_player = get_node("AnimationPlayer")
onready var label = get_node("Label")
onready var label_submessage = get_node("Label2")
onready var blood = get_node("Blood")

func show_message(message, submessage = "", color = Color("#ff6464")):
	label.text = message
	label_submessage.text = submessage
	label.set("custom_colors/font_color", color)
	label_submessage.set("custom_colors/font_color", color)
	blood.modulate = color
	animation_player.play("display")


func fade():
	animation_player.play("fade")