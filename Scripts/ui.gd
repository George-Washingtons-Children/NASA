extends CanvasLayer

@onready var hp = $HealthBar

func update_health(value):
	hp.value = value
