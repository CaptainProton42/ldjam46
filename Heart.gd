extends RigidBody

var force = Vector3(0.0, 0.0, 0.0)
var up_force = 0.0
var charging = false
var charge = 0.0

func _on_Heart_input_event(camera, event, pos, normal, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == 1:
		charging = true
	if event is InputEventMouseButton and !event.pressed and event.button_index == 1:
		charging = false
		var force_dir = -normal
		force = 4.0 * force_dir.normalized();
		force.y = 10.0 * charge
		charge = 0.0

func _physics_process(delta):
	if charging:
		charge += delta
		if (charge > 1.0):
			charge = 1.0
	apply_impulse(Vector3(0.0, 0.0, 0.0), force)
	if force != Vector3(0.0, 0.0, 0.0):
		force = Vector3(0.0, 0.0, 0.0)
	if get_colliding_bodies().size() > 0:
		linear_damp = 0.99
	else:
		linear_damp = 0.0
