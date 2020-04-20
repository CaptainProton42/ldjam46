extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var leveldisplay = "Tutorial"
export var levelname = "TutorialLevel"

var level_button

# Called when the node enters the scene tree for the first time.
func _ready():
	level_button = get_node("MenuContainer/HSplitContainer/VBoxContainer/ButtonSelectLevel")
	level_button.text = leveldisplay


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	level_button.text = leveldisplay + " (Selected)"


func _on_ButtonStart_pressed():
	#var nodeBackground = get_node("../Background")
	#nodeBackground.hide()
	
	#var nodeHeart = get_node("../Heart")
	#nodeHeart.menuActive = false
	
	get_tree().change_scene("res://" + levelname + ".tscn")
	#var nodeContainer = get_node("MenuContainer")
	#nodeContainer.hide()

func _on_ButtonSelectLevel_pressed():
	var nodeLevelMenu = get_node("../LevelMenu")
	nodeLevelMenu.show()
	
	
