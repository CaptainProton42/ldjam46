extends Spatial

export var heart_path : NodePath
onready var heart = get_node(heart_path)

onready var text_perfect = get_node("MeshPerfect")
onready var text_good = get_node("MeshGood")

onready var dashed_circle = get_node("MeshDashed")
onready var charge_circle = get_node("MeshInstance")
onready var animation_player = get_node("AnimationPlayer")
onready var animation_tree = get_node("AnimationTree")
onready var arrow = get_node("Arrow")

var force

func _ready():
	animation_tree.active = true
	heart.connect("heartbeat", self.animation_tree, "set", ["parameters/heartbeat/seek_position", 0.0])
	heart.connect("jump", self, "_on_jump")
	heart.connect("entered_state", self, "_on_heart_entered_state")
	heart.help_circle = self

func _on_jump(timing_quality):
	if timing_quality == heart.TIMING.perfect:
		text_good.visible = false
		text_perfect.visible = true
		animation_tree.set("parameters/pop/seek_position", 0.0)
	elif timing_quality == heart.TIMING.good:
		text_good.visible = true
		text_perfect.visible = false
		animation_tree.set("parameters/pop/seek_position", 0.0)

func _process(_delta):
	translation = heart.translation
	animation_tree.set("parameters/amplitude/blend_amout", heart.life)
	charge_circle.get_surface_material(0).set_shader_param("fill", heart.charge)

func _on_heart_entered_state(state):
	if state == heart.STATE.charging:
		arrow.visible = true
	else:
		arrow.visible = false

	if state == heart.STATE.idle or state == heart.STATE.charging:
		dashed_circle.get_surface_material(0).set_shader_param("active", true)
		charge_circle.get_surface_material(0).set_shader_param("active", true)
	else:
		dashed_circle.get_surface_material(0).set_shader_param("active", false)
		charge_circle.get_surface_material(0).set_shader_param("active", false)

	if state == heart.STATE.dead:
		visible = false
	else:
		visible = true
