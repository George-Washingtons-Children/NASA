extends ProgressBar

@export var color = "ff0000"

func _ready():
	var sb = StyleBoxFlat.new()
	add_theme_stylebox_override("fill", sb)
	sb.bg_color = Color(color)
