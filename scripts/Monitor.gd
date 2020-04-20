extends Control

onready var monitor_line = preload("res://MonitorLine.tscn")
onready var viewport = get_node("Viewport")
onready var heart = get_node(heart_path)

export var heart_path : NodePath

var line_1
var line_2

var width = 400

var amplitude = 1.0

func _ready():
	heart.connect("heartbeat", self, "add_blip")

func add_blip():
	var blip = monitor_line.instance()
	blip.position.x = width
	for i in range(blip.points.size()):
		blip.points[i].y *= amplitude
	viewport.add_child(blip)

func _process(delta):
	amplitude = heart.life
	for i in range(viewport.get_child_count()):
		var blip = viewport.get_child(i)
		blip.position.x -= width * delta
		if blip.position.x < -width:
			blip.queue_free()
