extends Node2D

func _ready():
	$Player.health_changed.connect($"/root/SystemManager".update_health)
	$Player.oxygen_changed.connect($"/root/SystemManager".update_oxygen)
	$Player.hunger_changed.connect($"/root/SystemManager".update_hunger)
	$Player.malfunction.connect($"/root/SystemManager".update_malfunction)
	
	$"Level Design".rock.connect($"/root/SystemManager".update_rock)
	$"Level Design".water.connect($"/root/SystemManager".update_water)
	$"Level Design".ice.connect($"/root/SystemManager".update_ice)
	
	$"Level Design".rock.connect($UI.update_rock)
	$"Level Design".water.connect($UI.update_water)
	$"Level Design".ice.connect($UI.update_ice)
	
	$"/root/SystemManager".healthSig.connect($UI.update_health)
	$"/root/SystemManager".oxygenSig.connect($UI.update_oxygen)
	$"/root/SystemManager".hungerSig.connect($UI.update_hunger)
	
	$Player.selectMatChange.connect($UI.update_select)


func _on_area_2d_body_entered(body):
	if (body.get_name() == "Player"):
		pass

func _on_hab_area_body_entered(body):
	if (body.get_name() == "Player"):
		#MAKE A POP UP TO TELL PLAYER TO PRESS 'E'
		pass
