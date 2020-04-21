extends StaticBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var projectResolution;
var startPosition
export var menuActive = true

# Called when the node enters the scene tree for the first time.
func _ready():
	projectResolution = Vector2(ProjectSettings.get_setting("display/window/size/width") ,ProjectSettings.get_setting("display/window/size/height"))
	startPosition = translation


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (menuActive):
		var diff = projectResolution - OS.get_window_size()
		var size = 0.5 - diff.y / 900
		
		translation = Vector3(-3 + diff.y / 200, 0.1, -1.9 + diff.x / 500)
		scale = Vector3(size, size, size) * 10
		
		rotate_y(delta)
