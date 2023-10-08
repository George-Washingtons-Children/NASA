extends Node2D

func _ready():
	$Player.health_changed.connect($UI.update_health)
	$Player.oxygen_changed.connect($UI.update_oxygen)
	$Player.hunger_changed.connect($UI.update_hunger)
