extends StaticBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var forceHeart = 5.0
export var forceObjects = 8.0


# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_Area_body_entered(body):
	if body.get_name() == "Heart":	
		body.apply_impulse(Vector3(0.0, 0.0, 0.0), Vector3(0.0, 1.0, 0.0) * forceHeart)
		throwObjects()
	
	print(body)
	
func throwObjects():
	var objects = get_node("ThrowArea").get_overlapping_bodies()
	print("--------")
	for node in objects:
		if !(node is StaticBody) && !node.get_name() == "Heart":
			node.apply_impulse(Vector3(0.0, 0.0, 0.0), Vector3(0.0, 1.0, 0.0) * forceObjects)
			print(node.get_name())
	print("--------")
		
