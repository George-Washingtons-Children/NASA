extends CharacterBody2D

var health = 10
var invinCount = 5
var invinTime = 0
var oxygen = 1000
var malfunctioning = false

var rng = RandomNumberGenerator.new()

@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
# 9.81 m/s^2 = earth gravity, gravity set to 980
# 1.4 m/2^2 = titan gravity
# 980 / 9.81 * 1.4 = 139.857

func _physics_process(delta):
	rng.randomize()
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider().is_in_group("enemy") and invinTime <= 0:
			print("collided")
			velocity.x = move_toward(-1 * velocity.x, 0, -1 * SPEED)
			invinTime = invinCount
			health -= 1
			print(health)
		if collision.get_collider().is_in_group("pickup"):
			print("pickup")

	if (invinTime > 0):
		invinTime -= delta
	
	if (oxygen >= 0 and get_tree().current_scene.name != "Menu" and get_tree().current_scene.name != "Hab"):
		oxygen -= delta * 2
		if (oxygen < 0):
			print("death by axphixiation")
			
	
	if (get_tree().current_scene.name != "Menu" and get_tree().current_scene.name != "Hab"):
		get_node("MalfunctionTimer").set_paused(false)
	else:
		get_node("MalfunctionTimer").set_paused(true)
	

func _on_pickup_area_entered(area):
	print("pickup")


func _on_malfunction_timer_timeout():
	var mal = rng.randi_range(1, 10)
	if (mal == 1):
		malfunctioning = true
	print(mal)
	print(malfunctioning)
