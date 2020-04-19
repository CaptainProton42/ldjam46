extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var level1 = Button.new()
	level1.text = "Level 1"
	level1.draw_rect(Rect2(Vector2(0,0), Vector2(150, 100)), Color.black)
	
	var line1 = get_node("MarginContainer/VBoxContainer/VBoxContainer/Line1")
	line1.add_child(level1)
	
	var level2 = Button.new()
	level2.text = "Level 1"
	line1.add_child(level2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_BackButton_pressed():
	hide()
