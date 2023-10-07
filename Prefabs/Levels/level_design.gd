extends TileMap

var holdCount = 3
var holdTime = 0
var tilepos
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
			
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and get_tree().current_scene.name != "Menu" and get_tree().current_scene.name != "Hab":
			tilepos = local_to_map(event.position)
			print(tilepos)
			print(get_cell_source_id(0, tilepos))
			if (get_cell_source_id(0, tilepos) == 2):
				get_node("Timer").start(3)
				#print(get_cell_atlas_coords(0, tilepos))
				#set_cell(0, tilepos, 1, Vector2i(0,0))
			elif (get_cell_source_id(0, tilepos) == 1):
				print(get_cell_atlas_coords(0, tilepos))
				set_cell(0, tilepos, 2, Vector2i(0,0))
		if event.pressed == false:
			get_node("Timer").stop()
			print("stop")


func _on_timer_timeout():
	print("timeout")
	print(get_cell_atlas_coords(0, tilepos))
	set_cell(0, tilepos, 1, Vector2i(0,0))
