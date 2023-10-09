extends Node

var ice = 0
var rock = 0
var water = 0
var iron = 0

var health = 10
var oxygen = 1000
var food = 1000
var malfunctioning = false
var rateMultiplier = 1

var waterpack = true

var select = 1

signal healthSig
signal oxygenSig
signal hungerSig


func update_health(value):
	health += value * rateMultiplier
	emit_signal("healthSig", health)
	check_death(health)

func check_death(curHealth):
	if (curHealth <= 0):
		get_tree().change_scene_to_file("res://Scenes/Game Over.tscn")
		health = 10

func update_oxygen(value):
	if (oxygen >= 0 and oxygen <= 1000):
		oxygen += value * rateMultiplier
		emit_signal("oxygenSig", oxygen)

	
	if (oxygen < 0):
		get_tree().change_scene_to_file("res://Scenes/Game Over.tscn")
		oxygen = 1000;

func update_hunger(value):
	if(food >= 0 and food <= 1000):
		food += value * rateMultiplier
		emit_signal("hungerSig", food)
	if (food < 0):
		get_tree().change_scene_to_file("res://Scenes/Game Over.tscn")
		food = 1000;
func waterpackUpdate(value):
	waterpack = value
	print("got water?")
	
func update_malfunction(value):
	malfunctioning = value
	if (malfunctioning == true):
		rateMultiplier = 3
	else:
		rateMultiplier = 1
	print(malfunctioning)
# Called when the node enters the scene tree for the first time.

func update_ice(value):
	ice += value
	
func update_rock(value):
	rock += value
	
func update_water(value):
	water += value

func update_iron(value):
	iron += value
	
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	emit_signal("healthSig", health)
	emit_signal("oxygenSig", oxygen)
	emit_signal("hungerSig", food)

			
func checkInHab():
	if(get_tree().current_scene.name == "Hab"):
		if(oxygen < 1000):
			oxygen += 1.5;
			emit_signal("oxygenSig", food)
