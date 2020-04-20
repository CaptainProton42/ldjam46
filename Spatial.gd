extends Spatial

export var num_nodes = 20
export var spacing = 0.15

var force = Vector3(0.0, -9.81, 0.0)

var nodes = []

onready var node = preload("res://PredictorNode.tscn")

func _ready():
	for i in range(num_nodes):
		nodes.append(node.instance())
		add_child(nodes[i])

func set_impulse(impulse):
	if impulse:
		var pos = Vector3(0.0, 0.0, 0.0)
		for i in range(num_nodes):
			pos += impulse * spacing
			impulse += spacing * force
			nodes[i].translation = pos
