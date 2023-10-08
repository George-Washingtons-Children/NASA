extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_hab_area_body_entered(body):
	if (body.get_name() == "Player"):
		print("entering hab area")
		get_node("HabEnter").visible = true;
		
func _on_hab_area_body_exit(body):
	if (body.get_name() == "Player"):
		print("leaving hab area")
		get_node("HabEnter").visible = false;

