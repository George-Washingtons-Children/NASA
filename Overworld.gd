extends Node2D

var inHab;

func _ready():
	$Player.health_changed.connect($"/root/SystemManager".update_health)
	$Player.oxygen_changed.connect($"/root/SystemManager".update_oxygen)
	$Player.hunger_changed.connect($"/root/SystemManager".update_hunger)
	$Player.malfunction.connect($"/root/SystemManager".update_malfunction)
	$Player.malfunction.connect($UI.update_mal)
	
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
	
	inHab = false;

func _process(delta):
	checkEnter()

func _on_area_2d_body_entered(body):
	if(body.get_name() == "Player"):
		print("entering hab area")
		inHab = true;
		get_node("HabEnter").visible = true;

func _on_area_2d_body_exited(body):
	if (body.get_name() == "Player"):
		print("exiting hab area")
		inHab = false;
		get_node("HabEnter").visible = false;

func _on_hab_area_body_entered(body):
	if(body.get_name() == "Player"):
		print("entering hab area")
		inHab = true;
		get_node("HabEnter").visible = true;
		
func checkEnter():
	if(inHab && Input.is_action_just_pressed("Interaction")):
		print("entering hab scene")
		get_node("HabEnter").visible = false;
		get_tree().change_scene_to_file("res://Scenes/hab.tscn")
