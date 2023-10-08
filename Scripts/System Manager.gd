extends Node

var ice = 0
var rock = 0
var water = 0

var health = 10
var oxygen = 1000
var food = 1000
var malfunctioning = false
var rateMultiplier = 1

var waterpack = false

var select = 1

signal healthSig
signal oxygenSig
signal hungerSig

func update_health(value):
	health += value * rateMultiplier
	emit_signal("healthSig", health)

func update_oxygen(value):
	if (oxygen >= 0 and oxygen <= 1000):
		oxygen += value * rateMultiplier
		emit_signal("oxygenSig", oxygen)
		
	if (oxygen < 0):
			print("death by axphixiation")

func update_hunger(value):
	if(food >= 0 and food <= 1000):
		food += value * rateMultiplier
		emit_signal("hungerSig", food)
	if (food < 0):
		print("death by starvation")

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
	print(rock)
	
func update_water(value):
	water += value
	
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_pickup_body_entered(body):
	if (body.get_name() == "Player"):
		if(food < 1000 && food > 0):
			food += 333;
			emit_signal("hungerSig", food)
			
func checkInHab():
	if(get_tree().current_scene.name == "Hab"):
		if(oxygen < 1000):
			oxygen += 1.5;
			emit_signal("oxygenSig", food)
