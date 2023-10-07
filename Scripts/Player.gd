extends CharacterBody2D

var health = 5
var invinCount = 5
var invinTime = 0

@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
# 9.81 m/s^2 = earth gravity, gravity set to 980
# 1.4 m/2^2 = titan gravity
# 980 / 9.81 * 1.4 = 139.857

func _physics_process(delta):
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

func _on_pickup_area_entered(area):
	print("pickup")
