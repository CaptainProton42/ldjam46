extends Spatial

onready var heart = get_node("../Heart")

func _process(delta):
	translation = heart.translation
	get_node("MeshInstance").rotation = heart.rotation
	scale.y = 1.0 - 0.5 * heart.charge
	scale.x = 1.0 + 0.5 * heart.charge
	scale.z = 1.0 + 0.5 * heart.charge