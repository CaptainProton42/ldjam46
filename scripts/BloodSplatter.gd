extends MeshInstance

export var lifetime = 10.0

var time = 0.0

func _ready():
	set_surface_material(0, get_surface_material(0).duplicate())
	get_node("AnimationPlayer").play("spill")

func _process(delta):
	time += delta
	if (time >= lifetime):
		get_node("AnimationPlayer").play("fade")
		yield(get_node("AnimationPlayer"), "animation_finished")
		queue_free()
