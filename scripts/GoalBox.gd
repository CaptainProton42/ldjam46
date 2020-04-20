extends StaticBody

onready var animation_player = get_node("AnimationPlayer")
onready var win_trigger = get_node("WinTrigger")

func _ready():
	win_trigger.connect("boxed", animation_player, "play", ["close"])