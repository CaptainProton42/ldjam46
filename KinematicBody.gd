extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _physics_process(delta):
	var velocity = Vector3(0, 0, 0)
	if Input.is_action_pressed("forward"):
		velocity.y = 10.0
	if Input.is_action_pressed("backwad"):
		velocity.y = -10.0
	print(velocity)
	move_and_slide(velocity)
