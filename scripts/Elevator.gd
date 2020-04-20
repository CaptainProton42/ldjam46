extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var max_height = 2

var platform
var material
var mesh
var start_pos
var direction = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	mesh = get_node("Platform/Mesh")
	material = mesh.get_surface_material(0)
	platform = get_node("Platform")
	start_pos = platform.translation


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if max_height - 0.3 < platform.translation.y - start_pos.y:	
		material.albedo_color = Color(0, 1, 0)
	elif start_pos.y + 0.3 > platform.translation.y:
		material.albedo_color = Color(0, 1, 0)
	else:
		material.albedo_color = Color(1, 1, 0)
	mesh.set_surface_material(0, material)
	
	if max_height < platform.translation.y - start_pos.y:
		direction = -1
	elif platform.translation.y < start_pos.y:
		direction = 1
	platform.translation += Vector3(0, delta * 0.5 * direction, 0)
	print(platform.translation.y - start_pos.y)
