extends Area2D

signal pickup
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	if (body.get_name() == "Player"):
		if(SystemManager.food < 1000 && SystemManager.food > 0):
			SystemManager.food += 333;
			SystemManager.food = minf(SystemManager.food, 1000);
			emit_signal("hungerSig", SystemManager.food)
			queue_free()
