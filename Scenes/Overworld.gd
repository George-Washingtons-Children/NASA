extends Node2D

func _ready():
	$Player.health_changed.connect($UI.update_health)
