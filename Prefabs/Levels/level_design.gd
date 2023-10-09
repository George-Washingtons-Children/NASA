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
signal iron
# Called when the node enters the scene tree for the first time.
func _ready():
	emit_signal("water", 1)
	emit_signal("rock", 1)
	emit_signal("ice", 1)
	emit_signal("iron", 1)
	print("Second")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	emit_signal("water", 0)
	emit_signal("rock", 0)
	emit_signal("ice", 0)
	emit_signal("iron", 0)
		
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and get_tree().current_scene.name != "Menu" and get_tree().current_scene.name != "hab":
			event = make_input_local(event)
			tilepos = local_to_map(event.position)
			if (get_cell_source_id(0, tilepos) != -1 and get_node("Break").playing == false):
				get_node("Break").play()
			sourceid = get_cell_source_id(0, tilepos)
			if (get_cell_source_id(0, tilepos) == 2):
				get_node("Timer").start(holdCount)
				#print(get_cell_atlas_coords(0, tilepos))
				#set_cell(0, tilepos, 1, Vector2i(0,0))
			elif (get_cell_source_id(0, tilepos) == 7):
				get_node("Timer").start(holdCount)
			elif (get_cell_source_id(0, tilepos) == 1 and SystemManager.waterpack == true and SystemManager.water < 10):
				get_node("Timer").start(holdCount)
			elif (get_cell_source_id(0, tilepos) == 6):
				get_node("Timer").start(holdCount)
			elif (get_cell_source_id(0, tilepos) == -1):
				if (SystemManager.select == 1 and SystemManager.rock > 0):
				#print(get_cell_atlas_coords(0, tilepos))
					set_cell(0, tilepos, 2, Vector2i(0,0))
					emit_signal("rock", -1)
				elif (SystemManager.select == 3 and SystemManager.iron > 0):
				#print(get_cell_atlas_coords(0, tilepos))
					set_cell(0, tilepos, 6, Vector2i(0,0))
					emit_signal("iron", -1)
				elif (SystemManager.select == 2 and SystemManager.ice > 0):
				#print(get_cell_atlas_coords(0, tilepos))
					set_cell(0, tilepos, 7, Vector2i(0,0))
					emit_signal("ice", -1)
		if event.pressed == false:
			get_node("Timer").stop()
			get_node("Break").stop()


func _on_timer_timeout():
	#print(get_cell_atlas_coords(0, tilepos))
	if (sourceid == 2):
		emit_signal("rock", 1)
	elif (sourceid == 1):
		emit_signal("water", 1)
	elif (sourceid == 7):
		emit_signal("ice", 1)
	elif (sourceid == 6):
		emit_signal("iron", 1)
	set_cell(0, tilepos, -1, Vector2i(0,0))
