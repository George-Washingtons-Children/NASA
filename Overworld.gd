extends Node2D

func _ready():
	$Player.health_changed.connect($UI.update_health)
	$Player.oxygen_changed.connect($UI.update_oxygen)
	$Player.hunger_changed.connect($UI.update_hunger)


func _on_area_2d_body_entered(body):
	if (body.get_name() == "Player"):


func _on_hab_area_body_entered(body):
	if (body.get_name() == "Player"):
		#MAKE A POP UP TO TELL PLAYER TO PRESS 'E'

