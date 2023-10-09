extends Node2D


func _ready():
	get_window().mode = Window.MODE_MAXIMIZED


func _on_quit_button_pressed():
	get_tree().quit;

func _on_play_button_pressed():
	SystemManager.rock = 0
	SystemManager.ice = 0
	SystemManager.water = 0
	SystemManager.iron = 0
	SystemManager.health = 10
	SystemManager.food = 1000
	SystemManager.oxygen = 1000
	SystemManager.malfunctioning = false
	get_tree().change_scene_to_file("res://Scenes/Overworld.tscn")

	
func _on_return_to_menu_button_pressed():
	SystemManager.rock = 0
	SystemManager.ice = 0
	SystemManager.water = 0
	SystemManager.iron = 0
	SystemManager.health = 10
	SystemManager.food = 1000
	SystemManager.oxygen = 1000
	SystemManager.malfunctioning = false
	get_tree().change_scene_to_file("res://Scenes/Menu.tscn")
	
