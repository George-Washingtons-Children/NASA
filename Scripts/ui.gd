extends CanvasLayer

@onready var hp = $HealthBar
@onready var otwo = $OxygenBar
@onready var hun = $HungerBar
@onready var wat = $WaterBar

@onready var slot1 = $Hotbar/Panel/Slot1/Slot1Text
@onready var slot2 = $Hotbar/Panel/Slot2/Slot2Text
@onready var slot3 = $Hotbar/Panel/Slot3/Slot3Text

@onready var select = [$Hotbar/Panel/oneSelect, $Hotbar/Panel/twoSelect, $Hotbar/Panel/threeSelect]

@onready var malfunction = $malText

func _ready():
	print("first")

func update_health(value):
	hp.value = value

func update_oxygen(value):
	otwo.value = value

func update_hunger(value):
	hun.value = value
	
func update_ice(_value):
	slot2.text = str(SystemManager.ice)

func update_rock(_value):
	slot1.text = str(SystemManager.rock)
	
func update_water(value):
	wat.value = value

func update_iron(_value):
	slot3.text = str(SystemManager.iron)

func update_select(value):
	for i in range (1, 4):
		print(i)
		if (i == value):
			select[i-1].visible = true
		else:
			select[i-1].visible = false
			
func update_mal(value):
	if (value == true):
		malfunction.visible = true
	else:
		malfunction.visible = false
