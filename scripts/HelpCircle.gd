extends MeshInstance

export var heart_path : NodePath
onready var heart = get_node(heart_path)

func _process(_delta):
	translation = heart.translation
