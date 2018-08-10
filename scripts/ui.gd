extends Control

onready var map = get_node("../../Nav/Map")
onready var selection = get_node("Selection")

func _process(delta):
	update()


func _draw():
	var pos = map.get_tile_at_mouse_position()
	selection.position = pos
	#draw_line(pos, pos + Vector2(64, 0), Color("#ff00ff00"), 5.0)
	#draw_line(pos, pos + Vector2(0, 64), Color("#ff00ff00"), 5.0)
	#draw_line(pos + Vector2(64, 0), pos + Vector2(64, 64), Color("#ff00ff00"), 5.0)
	#draw_line(pos + Vector2(0, 64), pos + Vector2(64, 64), Color("#ff00ff00"), 5.0)
	#print("drawing line at ", pos)