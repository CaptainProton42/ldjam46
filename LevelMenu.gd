extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var max_btn_per_line = 6
var level_style = load("res://styles/style_level_button.tres") 
var level_complete_style = load("res://styles/style_level_complete_button.tres") 

# Called when the node enters the scene tree for the first time.
func _ready():
	var level_list = [["Level 1", true, "Levelname"], ["Level 2", true, "Levelname"], ["Level 3", true, "Levelname"], ["Level 4", false, "Levelname"], ["Level 5", false, "Levelname"], ["Level 6", false, "Levelname"], ["Level 7", false, "Levelname"], ["Level 8", false, "Levelname"]]
	
	var parent = get_node("MarginContainer/ScrollContainer/VBoxContainer/VBoxContainer/")
	
	var c_node
	var c_line = 0
	for level_e in level_list:
		if c_line < max_btn_per_line - 1:
			if c_line == 0:
				c_node = HBoxContainer.new()
				parent.add_child(c_node)	
			c_line += 1
		else:
			c_line = 0			
		c_node.add_child(createLevelButton(level_e[0], level_e[1]))

## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_BackButton_pressed():
	hide()

func createLevelButton(text, is_complete = false):
	var levelButton = Button.new()
	if is_complete:
		levelButton.add_stylebox_override("normal", level_complete_style)
	else:
		levelButton.add_stylebox_override("normal", level_style)
	levelButton.text = text
	levelButton.update()
	return levelButton
