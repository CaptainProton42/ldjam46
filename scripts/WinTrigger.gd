extends Area

func _on_body_entered(body):
	if body.get_name() == "Heart":
		body._enter_state(body.STATE.boxed)
