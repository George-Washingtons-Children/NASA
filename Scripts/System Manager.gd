extends Node

var ice = 0
var rock = 0
var water = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _on_pickup_body_entered(body):
	if (body.get_name() == "Player"):
		mats += 1
		print(mats)
