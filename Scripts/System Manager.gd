extends Node

var mats = 0

var PlayerHp = 1000;
#CALL THIS BY USING Global.PlayerHp
var PlayerHunger = 1000;
#CALL THIS BY USING Global.PlayerHunger

func set_HealthBar() -> void:
	$HealthBar.value = PlayerHp;
	
func set_HungerBar() -> void:
	$HungerBar.value = PlayerHunger;
	
# Called when the node enters the scene tree for the first time.
func _ready():
	set_HealthBar()
	set_HungerBar()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _on_pickup_body_entered(body):
	if (body.get_name() == "Player"):
		mats += 1
		print(mats)
