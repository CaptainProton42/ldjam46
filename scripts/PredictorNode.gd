extends Spatial

var colliding = false

func _process(delta):
	var bodies = get_node("Area").get_overlapping_bodies()
	var body_count = bodies.size()
	colliding = false
	if bodies.size() > 0:
		for i in range(bodies.size()):
			if bodies[i].name == "Heart":
				body_count -= 1
		if body_count > 0:
			colliding = true
