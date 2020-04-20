extends RigidBody

onready var collider_input = get_node("AreaInput")
onready var collider_physics = get_node("CollisionShapePhysics")
onready var animation_player = get_node("AnimationPlayer")
onready var animation_tree = get_node("AnimationTree")
onready var material = get_node("CollisionShapePhysics/MeshInstance").get_surface_material(0)

onready var splatter_spawner = preload("res://SpawnBloodSplatter.tscn")
onready var particles = get_node("CPUParticles")

export var jump_force = 5.0
export var speed_idle = 0.2
export var time_till_death = 5.0
export var timing_bonus = 2.0 # multiplier
export var timing_interval_perfect = 0.15
export var timing_interval_good = 0.3

var help_circle

var rng = RandomNumberGenerator.new()

enum TIMING {
	perfect,
	good,
	normal
}

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

var timer = 0.0
var pulse_interval = 1.0

signal dead
signal jump
signal heartbeat
signal entered_state

var charge_normal

func _ready():
	animation_tree.set_active(true)
	animation_tree.set("parameters/heartbeat_amplitude/blend_amount", 0.5)
	rng.randomize()

func _enter_state(new_state):
	print("entering state " + STATE.keys()[new_state])
	state = new_state
	emit_signal("entered_state", new_state)

func _on_mouse_exited():
	if state == STATE.charging:
		_enter_state(STATE.idle)
		charge = 0.0

func _on_mouse_entered():
	if Input.is_action_pressed("charge"):
		_enter_state(STATE.charging)

func _on_collider_input(camera, event, pos, normal, shape_idx):
	charge_normal = normal
	if Input.is_action_just_pressed("charge"):
		if state == STATE.idle:
			_enter_state(STATE.charging)
	if Input.is_action_just_released("charge"):
		if state == STATE.charging:
			var force_dir = -normal
			restart_heart(force_dir)

func _process(delta):
	timer += delta
	if state == STATE.charging or state == STATE.idle:
		life -= delta / time_till_death
		animation_tree.set("parameters/heartbeat_amplitude/blend_amount", life)
	if state == STATE.charging:
		if Vector2(charge_normal.x, charge_normal.z).length() < 0.15:
			help_circle.arrow.visible = false
		else:
			help_circle.arrow.rotation.y = Vector2(charge_normal.x, charge_normal.z).angle_to(Vector2(0.0, 1.0))
			help_circle.arrow.visible = true
		material.set_shader_param("squish", charge)
		material.set_shader_param("squish_dir", charge_normal)
	if state != STATE.dead:
		if (life <= 0.0):
			emit_signal("dead")
			_enter_state(STATE.dead)

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
			linear_damp = 0.0
			_enter_state(STATE.falling)
	if state == STATE.rolling:
		if linear_velocity.length() < speed_idle:
			_enter_state(STATE.idle)

func _integrate_forces( physics_state ):
	if state == STATE.falling:
		if (physics_state.get_contact_count() >= 1):  #this check is needed or it will throw errors
			var collider = physics_state.get_contact_collider_object(0)
			if collider.get_collision_layer_bit(0):
				var collision_pos = physics_state.get_contact_collider_position(0)
				var collision_normal = physics_state.get_contact_local_normal(0)
				var splatter = splatter_spawner.instance()
				#get_parent().add_child(splatter)
				splatter.look_at(collision_normal.rotated(Vector3(-1.0, 0.0, 0.0), 0.5*PI), Vector3(0.0, 1.0, 0.0))
				splatter.translation = collision_pos + Vector3(0.0, 0.001, 0.0)
				linear_damp = 0.8
				_enter_state(STATE.rolling)
			
func restart_heart(force_dir):
	life = 1.0 / timing_bonus
	charging = false
	animation_tree.set("parameters/heartbeat_restart/seek_position", 0.0)
	var force = (0.3 + 0.7*charge) * jump_force * force_dir.normalized() / timing_bonus
	force.y *= -1.0
	var timing_quality = TIMING.normal
	var timing = abs(timer - 0.15 - round(timer - 0.15) / pulse_interval) # die animation is etwas verschoben
	print(timing)
	if timing < timing_interval_perfect:
		print("PERFECT")
		timing_quality = TIMING.perfect
		life *= timing_bonus
		force *= timing_bonus
	elif timing < timing_interval_good:
		life *= timing_bonus * 0.75
		force *= timing_bonus * 0.75
		print("GOOD")
		timing_quality = TIMING.good
		
	add_torque(10.0 * charge * Vector3(rng.randf(), rng.randf(), rng.randf()).normalized())
	apply_impulse(Vector3(0.0, 0.0, 0.0), force)
	timer = 0.0
	charge = 0.0
	emit_signal("jump", timing_quality)
	_enter_state(STATE.falling)
