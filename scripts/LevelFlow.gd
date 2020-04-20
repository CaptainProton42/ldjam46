extends Node

export var heart_path : NodePath
export var text_announcer_path : NodePath

onready var heart = get_node(heart_path)
onready var text_announcer = get_node(text_announcer_path)

# Called when the node enters the scene tree for the first time.
func _ready():
	heart.connect("entered_state", self, "_on_heart_entered_state")

func _input(event):
	if heart.state == heart.STATE.dead:
		if Input.is_action_just_pressed("restart"):
			get_tree().reload_current_scene()
	if heart.state == heart.STATE.boxed:
		if Input.is_action_just_pressed("restart"):
			print("YAY")
		

func _on_heart_entered_state(state):
	if state == heart.STATE.dead:
		text_announcer.show_message("Flatlined", "press [SPACE] to restart")
	if state == heart.STATE.boxed:
		text_announcer.show_message("Boxed", "press [SPACE] to continue", Color("#3cbd4d"))
