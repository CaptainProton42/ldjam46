extends Control

onready var monitor_line = preload("res://MonitorLine.tscn")

var line_1
var line_2

var width = 400

var amplitude = 1.0

func _ready():
	line_1 = monitor_line.instance()
	line_2 = monitor_line.instance()
	get_node("Viewport").add_child(line_1)
	get_node("Viewport").add_child(line_2)
	line_1.position.x = 0
	line_2.position.x = width

func _process(delta):
	line_1.position.x -= width * delta
	line_2.position.x -= width * delta
	if line_1.position.x <= -width:
		line_1.position.x = width
		for i in range(line_1.points.size()):
			line_1.points[i].y = line_1.original_points[i].y * amplitude
	if line_2.position.x <= -width:
		line_2.position.x = width
		for i in range(line_2.points.size()):
			line_2.points[i].y = line_2.original_points[i].y * amplitude
