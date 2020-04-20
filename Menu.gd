extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ButtonStart_pressed():
	var nodeBackground = get_node("../Background")
	nodeBackground.hide()
	
	var nodeHeart = get_node("../Heart")
	nodeHeart.menuActive = false
	
	#var nodeContainer = get_node("MenuContainer")
	#nodeContainer.hide()
	hide()

func _on_ButtonSelectLevel_pressed():
	var nodeLevelMenu = get_node("../LevelMenu")
	nodeLevelMenu.show()
