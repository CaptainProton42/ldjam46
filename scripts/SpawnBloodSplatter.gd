extends Spatial

var rng = RandomNumberGenerator.new()

onready var splatter = preload("res://BloodSplatter.tscn")

export var num_splatters = 10

func _ready():
	rng.randomize()
	for i in range(1, num_splatters):
		var decal = splatter.instance()
		decal.translation.x += 0.3 * rng.randf() - 0.05
		decal.translation.z += 0.3 * rng.randf() - 0.05
		decal.scale *= 0.5 + 0.5 * rng.randf()
		add_child(decal)
