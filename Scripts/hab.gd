extends Node2D

var outHab = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	checkExit()


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
