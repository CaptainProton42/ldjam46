extends Camera

onready var heart = get_node("../Heart")
onready var offset = translation

func _process(delta):
	translation = heart.translation + offset