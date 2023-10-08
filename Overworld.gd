extends Node2D

var inHab;

func _ready():
	$Player.health_changed.connect($"/root/SystemManager".update_health)
	$Player.oxygen_changed.connect($"/root/SystemManager".update_oxygen)
	$Player.hunger_changed.connect($"/root/SystemManager".update_hunger)
	$Player.malfunction.connect($"/root/SystemManager".update_malfunction)
	
	$"/root/SystemManager".healthSig.connect($UI.update_health)
	$"/root/SystemManager".oxygenSig.connect($UI.update_oxygen)
	$"/root/SystemManager".hungerSig.connect($UI.update_hunger)
	
	inHab = false;
	
func _process(delta):
2	checkEnter()


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

func checkEnter():
	if(inHab && Input.is_action_just_pressed("Interaction")):
		print("entering hab scene")
		get_node("HabEnter").visible = false;
		get_tree().change_scene_to_file("res://Scenes/hab.tscn")
