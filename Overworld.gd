extends Node2D

func _ready():
	$Player.health_changed.connect($"/root/SystemManager".update_health)
	$Player.oxygen_changed.connect($"/root/SystemManager".update_oxygen)
	$Player.hunger_changed.connect($"/root/SystemManager".update_hunger)
	$Player.malfunction.connect($"/root/SystemManager".update_malfunction)
	
	$"/root/SystemManager".healthSig.connect($UI.update_health)
	$"/root/SystemManager".oxygenSig.connect($UI.update_oxygen)
	$"/root/SystemManager".hungerSig.connect($UI.update_hunger)


func _on_area_2d_body_entered(body):
	if (body.get_name() == "Player"):
		pass

func _on_hab_area_body_entered(body):
	if (body.get_name() == "Player"):
		#MAKE A POP UP TO TELL PLAYER TO PRESS 'E'
		pass
