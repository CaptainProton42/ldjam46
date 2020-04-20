extends Spatial

export var heart_path : NodePath

export var num_nodes = 40
export var spacing = 0.05

var force = Vector3(0.0, -9.81, 0.0)

var nodes = []

onready var node = preload("res://PredictorNode.tscn")
onready var heart = get_node(heart_path)
onready var animation_player = get_node("AnimationPlayer")

export var node_scale : float setget set_node_scale, get_node_scale
var _node_scale = 1.0

func set_node_scale(value):
	_node_scale = value
	if nodes.size() > 0:
		for i in range(num_nodes):
			nodes[i].scale = Vector3(1.0, 1.0, 1.0) * _node_scale

func get_node_scale():
	return _node_scale

func _ready():
	heart.connect("heartbeat", animation_player, "play", ["pulse"])
	heart.connect("entered_state", self, "_on_heart_entered_state")
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
			if nodes[i].colliding:
				break

func _on_heart_entered_state(state):
	if state == heart.STATE.charging:
		visible = true
	else:
		visible = false

func _process(_delta):
	translation = heart.translation
	if heart.state == heart.STATE.charging:
		var impulse = -heart.charge_normal.normalized() * heart.charge * heart.jump_force / heart.mass / 1.2
		impulse.y = -impulse.y
		set_impulse(impulse)
