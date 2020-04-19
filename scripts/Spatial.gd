extends Spatial

func _process(delta):
	rotation = -get_parent().get_parent().rotation
	get_node("Spatial").rotation = get_parent().get_parent().rotation
