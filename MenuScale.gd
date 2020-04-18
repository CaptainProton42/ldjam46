extends MeshInstance


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var projectResolution; 
var startPosition;

# Called when the node enters the scene tree for the first time.
func _ready():
	projectResolution = Vector2(ProjectSettings.get_setting("display/window/size/width") ,ProjectSettings.get_setting("display/window/size/height"))
	startPosition = translation


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var diff = projectResolution - OS.get_window_size()
	translation = Vector3(-3, 0.1 + diff.y / 500, -1.92 + diff.x / 500)
