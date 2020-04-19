extends RigidBody

onready var collider_input = get_node("AreaInput")
onready var collider_physics = get_node("CollisionBodyPhysics")
onready var animation_player = get_node("AnimationPlayer")
onready var animation_tree = get_node("AnimationTree")
onready var material = get_node("CollisionShapePhysics/MeshInstance").get_surface_material(0)
onready var monitor = get_node("../Monitor")

onready var splatter_spawner = preload("res://SpawnBloodSplatter.tscn")
onready var particles = get_node("CPUParticles")

export var jump_force = 5.0

enum STATE {
	charging,
	falling,
	rolling,
	idle,
	dead
}

var state = STATE.idle
var charging = false
var charge = 0.0

var on_floor = false

# Keep it alive!
var life = 1.0
var time_till_death = 3.0

signal dead

var charge_normal

func _ready():
	animation_tree.set_active(true)
	animation_tree.set("parameters/heartbeat_amplitude/blend_amount", 0.5)

func _enter_state(new_state):
	print("entering state " + STATE.keys()[new_state])
	state = new_state

func _on_collider_input(camera, event, pos, normal, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == 1:
		if state == STATE.idle:
			_enter_state(STATE.charging)
			charge = 0.0
			charge_normal = normal
	if event is InputEventMouseButton and !event.pressed and event.button_index == 1:
		if state == STATE.charging:
			var force_dir = -normal
			charge_normal = normal
			var force = (0.5 + 0.5*charge) * jump_force * force_dir.normalized()
			force.y *= -1.0
			apply_impulse(Vector3(0.0, 0.0, 0.0), force)
			restart_heart()

func _process(delta):
	if state == STATE.charging or state == STATE.idle:
		life -= delta / time_till_death
		animation_tree.set("parameters/heartbeat_amplitude/blend_amount", life)
	if state == STATE.charging:
		material.set_shader_param("squish", charge)
		material.set_shader_param("squish_dir", charge_normal)
	if state != STATE.dead:
		if (life <= 0.0):
			emit_signal("dead")
			_enter_state(STATE.dead)
	monitor.amplitude = life

func _physics_process(delta):
	if state == STATE.charging:
		charge += delta
		if (charge >= 1.0):
			charge = 1.0
	if state == STATE.falling:
		if get_colliding_bodies().size() > 0:
			pass
	if state == STATE.charging or state == STATE.idle or state == STATE.rolling:
		if get_colliding_bodies().size() == 0:
			_enter_state(STATE.falling)
	if state == STATE.rolling:
		if linear_velocity.length() < 0.1:
			_enter_state(STATE.idle)

func _integrate_forces( physics_state ):
	if state == STATE.falling:
		if (physics_state.get_contact_count() >= 1):  #this check is needed or it will throw errors
			var collision_pos = physics_state.get_contact_collider_position(0)
			var collision_normal = physics_state.get_contact_local_normal(0)
			var splatter = splatter_spawner.instance()
			splatter.look_at(collision_normal.rotated(Vector3(-1.0, 0.0, 0.0), 0.5*PI), Vector3(0.0, 1.0, 0.0))
			splatter.translation = collision_pos + Vector3(0.0, 0.001, 0.0)
			get_parent().add_child(splatter)
			_enter_state(STATE.rolling)
			
func restart_heart():
	life = 1.0
	charging = false
	animation_tree.set("parameters/heartbeat_restart/seek_position", 0.0)
	_enter_state(STATE.falling)
