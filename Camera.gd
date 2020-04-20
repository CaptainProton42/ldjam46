extends Camera

onready var heart = get_node("../Heart")
onready var offset = Vector3(0.0, 4.0, 0.0)

func _process(delta):
	translation = heart.translation + offset
