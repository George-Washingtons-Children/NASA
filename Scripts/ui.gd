extends CanvasLayer

@onready var hp = $HealthBar
@onready var otwo = $OxygenBar
@onready var hun = $HungerBar

func update_health(value):
	hp.value = value

func update_oxygen(value):
	otwo.value = value

func update_hunger(value):
	hun.value = value

