extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var direction = Vector3(0.0, 0.0, 1.0)
export var countdown = 5

var ball
var elapsed = 0
var start_pos

# Called when the node enters the scene tree for the first time.
func _ready():
	ball = get_node("Ball")
	start_pos = ball.translation


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(elapsed)
	if (countdown < elapsed):
		#respawn
		elapsed = 0
		ball.translation = start_pos
		ball.apply_impulse(Vector3(0.0, 0.0, 0.0), direction * 30)
		
	elapsed += delta
