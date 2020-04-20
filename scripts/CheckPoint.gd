extends Area

func _ready():
	connect("body_entered", self, "_on_body_entered")

func _on_body_entered(body):
	if body.get_name() == "Heart":
		body.checkpoint_position = translation + get_node("SpawnPoint").translation