extends StaticBody

onready var animation_player = get_node("AnimationPlayer")
onready var win_trigger = get_node("WinTrigger")

func disable_lid_collision():
	get_node("Lid/CollisionShape").disabled = true

func _ready():
	win_trigger.connect("boxed", animation_player, "play", ["close"])
	win_trigger.connect("boxed", self, "disable_lid_collision")