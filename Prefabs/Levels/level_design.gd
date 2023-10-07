extends TileMap

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
			
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			var tilepos = local_to_map(event.position)
			print(get_cell_source_id(0, tilepos))
			if (get_cell_source_id(0, tilepos) == 2):
				print(get_cell_atlas_coords(0, tilepos))
				set_cell(0, tilepos, 1, Vector2i(1,1), 0)
