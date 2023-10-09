extends CharacterBody2D

var healthRate = -2
var invinCount = 5
var invinTime = 0
var oxygenRate = -5
var foodRate = -3

signal watertank

signal health_changed
signal oxygen_changed
signal hunger_changed
signal malfunction

var selectMat

signal selectMatChange

var rng = RandomNumberGenerator.new()

@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
# 9.81 m/s^2 = earth gravity, gravity set to 980
# 1.4 m/2^2 = titan gravity
# 980 / 9.81 * 1.4 = 139.857

func _ready():
	rng.randomize()

func _physics_process(delta):
	# Add the gravity.
	#print(position.to_local())
	if not is_on_floor():
		velocity.y += gravity * delta
	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("walk left", "walk right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	if(velocity.x == 0 && velocity.y == 0 && is_on_floor()):
		$AnimationPlayer.play("Idle");
	elif(velocity.y < 0 && !is_on_floor()):
		$AnimationPlayer.play ("Jump");
		if(velocity.x < 0):
			get_node("Sprite2D").flip_h = false;
		elif(velocity.x > 0):
			get_node("Sprite2D").flip_h = true;
	elif(velocity.y >= 0 && !is_on_floor()):
		$AnimationPlayer.play ("Fall");
		if(velocity.x < 0):
			get_node("Sprite2D").flip_h = false;
		elif(velocity.x > 0):
			get_node("Sprite2D").flip_h = true;
	elif(velocity.x < 0):
		get_node("Sprite2D").flip_h = false
		$AnimationPlayer.play ("Walking");
	elif(velocity.x > 0):
		get_node("Sprite2D").flip_h = true
		$AnimationPlayer.play ("Walking");
		
	if (velocity.x != 0 and is_on_floor()): 
		if (get_tree().current_scene.name == "Overworld" and get_node("Walk").playing == false):
			print(velocity.x)
			get_node("Walk").play()
			get_node("WalkMetal").stop()
		elif (get_tree().current_scene.name == "Hab" and get_node("WalkMetal").playing == false):
			get_node("Walk").stop()
			get_node("WalkMetal").play()
	else:
		get_node("Walk").stop()
		get_node("WalkMetal").stop()
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider().is_in_group("enemy") and invinTime <= 0:
			print("collided")
			velocity.x = move_toward(-1 * velocity.x, 0, -1 * SPEED)
			invinTime = invinCount
			emit_signal("health_changed", healthRate)
			get_node("Hurt").play()
		if collision.get_collider().is_in_group("pickup"):
			print("pickup")
		if collision.get_collider().is_in_group("Hab"):
			pass

	if (invinTime > 0):
		invinTime -= delta
	
	
	if (get_tree().current_scene.name != "Menu" and get_tree().current_scene.name != "Hab"):
		get_node("MalfunctionTimer").set_paused(false)
	else:
		get_node("MalfunctionTimer").set_paused(true)
		
	if (get_tree().current_scene.name != "Menu" and get_tree().current_scene.name != "Hab" and SystemManager.oxygen > 0):
		emit_signal("oxygen_changed", oxygenRate * delta)
	elif (get_tree().current_scene.name == "Hab"):
		emit_signal("oxygen_changed", oxygenRate * delta * -1)
		
	if (get_tree().current_scene.name != "Menu" and get_tree().current_scene.name != "Hab" and SystemManager.food > 0):
		emit_signal("hunger_changed", foodRate * delta)
			
	if (SystemManager.food > 800 and SystemManager.health < 10):
		emit_signal("health_changed", healthRate * -0.1 * delta)
		emit_signal("hunger_changed", foodRate * delta)
	
	if (SystemManager.food <= 0):
		emit_signal("health_changed", healthRate * 0.25 * delta)
	
	if (SystemManager.oxygen <= 0):
		emit_signal("health_changed", healthRate * 0.5 * delta)
	
	#after crafting a watertank:
	emit_signal("watertank", true)
	
	if (Input.is_key_pressed(KEY_1)):
		selectMat = 1
		SystemManager.select = selectMat
	elif (Input.is_key_pressed(KEY_2)):
		selectMat = 2
		SystemManager.select = selectMat
	elif (Input.is_key_pressed(KEY_3)):
		selectMat = 3
		SystemManager.select = selectMat
	SystemManager.select = selectMat
	emit_signal("selectMatChange", SystemManager.select)

func _on_pickup_area_entered(area):
	print("pickup")


func _on_malfunction_timer_timeout():
	var mal = rng.randi_range(1, 10)
	if (mal == 1):
		emit_signal("malfunction", true)
	print(mal)

