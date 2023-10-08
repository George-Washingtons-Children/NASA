extends TileMap

var holdCount = 2.3
var holdTime = 0
var tilepos

var icecount
var rockcount
var watercount

var sourceid

signal ice
signal rock
signal water
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
			
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and get_tree().current_scene.name != "Menu" and get_tree().current_scene.name != "Hab":
			event = make_input_local(event)
			tilepos = local_to_map(event.position)
			print(tilepos)
			sourceid = get_cell_source_id(0, tilepos)
			if (get_cell_source_id(0, tilepos) == 2):
				get_node("Timer").start(holdCount)
				#print(get_cell_atlas_coords(0, tilepos))
				#set_cell(0, tilepos, 1, Vector2i(0,0))
			elif (get_cell_source_id(0, tilepos) == 7):
				get_node("Timer").start(holdCount)
			elif (get_cell_source_id(0, tilepos) == 1 and SystemManager.waterpack == true):
				get_node("Timer").start(holdCount)
			elif (get_cell_source_id(0, tilepos) == -1):
				if (SystemManager.select == 1 and SystemManager.rock > 0):
				#print(get_cell_atlas_coords(0, tilepos))
					set_cell(0, tilepos, 2, Vector2i(0,0))
					emit_signal("rock", -1)
				elif (SystemManager.select == 3 and SystemManager.water > 0):
				#print(get_cell_atlas_coords(0, tilepos))
					set_cell(0, tilepos, 1, Vector2i(0,0))
					emit_signal("water", -1)
				elif (SystemManager.select == 2 and SystemManager.ice > 0):
				#print(get_cell_atlas_coords(0, tilepos))
					set_cell(0, tilepos, 7, Vector2i(0,0))
					emit_signal("ice", -1)
		if event.pressed == false:
			get_node("Timer").stop()


func _on_timer_timeout():
	#print(get_cell_atlas_coords(0, tilepos))
	if (sourceid == 2):
		emit_signal("rock", 1)
	elif (sourceid == 1):
		emit_signal("water", 1)
	elif (sourceid == 7):
		emit_signal("ice", 1)
	set_cell(0, tilepos, -1, Vector2i(0,0))
