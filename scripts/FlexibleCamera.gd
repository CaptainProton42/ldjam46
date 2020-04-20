extends Spatial

export var heart_path : NodePath
export var camera_height = 5.0

onready var heart = get_node(heart_path)
onready var ray = get_node("RayCast")
onready var camera = get_node("Camera")

func _ready():
	ray.cast_to = Vector3(0.0, camera_height - 0.5, 0.0)

func _process(delta):
	translation = heart.translation
	if ray.is_colliding():
		camera.translation = to_local(ray.get_collision_point())
	else:
		camera.translation = Vector3(0.0, camera_height, 0.0)