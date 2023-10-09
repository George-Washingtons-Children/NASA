extends Node2D

var outHab = false;
signal leaveHab
var inHydro = false;
var food = preload("res://Prefabs/pickup.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.health_changed.connect($"/root/SystemManager".update_health)
	$Player.oxygen_changed.connect($"/root/SystemManager".update_oxygen)
	$Player.hunger_changed.connect($"/root/SystemManager".update_hunger)
	$Player.malfunction.connect($"/root/SystemManager".update_malfunction)
	$Player.malfunction.connect($UI.update_mal)
	
	$"Level Design".rock.connect($"/root/SystemManager".update_rock)
	$"Level Design".water.connect($"/root/SystemManager".update_water)
	$"Level Design".ice.connect($"/root/SystemManager".update_ice)
	$"Level Design".iron.connect($"/root/SystemManager".update_iron)
	
	
	$"Level Design".rock.connect($UI.update_rock)
	$"Level Design".water.connect($UI.update_water)
	$"Level Design".ice.connect($UI.update_ice)
	$"Level Design".iron.connect($UI.update_iron)
	
	$"/root/SystemManager".healthSig.connect($UI.update_health)
	$"/root/SystemManager".oxygenSig.connect($UI.update_oxygen)
	$"/root/SystemManager".hungerSig.connect($UI.update_hunger)
	
	$Player.selectMatChange.connect($UI.update_select)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	checkExit()
	checkHydro()


func _on_hab_area_body_entered(body):
	if(body.get_name() == "Player"):
		print("entering hab area")
		outHab = true;
		get_node("HabEnter").visible = true;


func _on_hab_area_body_exited(body):
	if (body.get_name() == "Player"):
		print("exiting hab area")
		outHab = false;
		get_node("HabEnter").visible = false;

func checkExit():
	if(outHab && Input.is_action_just_pressed("Interaction")):
		print("entering hab scene")
		get_node("HabEnter").visible = false;
		get_tree().change_scene_to_file("res://Scenes/Overworld.tscn")

func _on_hydroponics_body_entered(body):
	if(body.get_name() == "Player"):
		print("entering hydro area")
		inHydro = true;
		get_node("Hydro").visible = true;


func _on_hydroponics_body_exited(body):
	if (body.get_name() == "Player"):
		print("exiting hydro area")
		inHydro = false;
		get_node("Hydro").visible = false;

func checkHydro():
	if(inHydro && Input.is_action_just_pressed("Interaction")):
		print("making food")
		get_node("Hydro").visible = false;
		makefood()
		
func makefood():
	var instance = food.instantiate()
	instance.position = Vector2(450,875)
	add_child(instance);
