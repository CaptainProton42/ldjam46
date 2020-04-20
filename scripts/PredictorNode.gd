extends Spatial

var colliding = false

func _process(delta):
	if get_node("Area").get_overlapping_bodies().size() > 0:
		colliding = true
	else:
		colliding = false
