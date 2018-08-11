extends Control

onready var level = get_node("../..")
onready var map = get_node("../../Map")
onready var selection = get_node("Selection")
onready var container = get_node("MarkerContainer")
onready var actors = get_node("../../Actors").get_children()

var move_marker = preload("res://assets/scenes/Marker.tscn")

var path : Array

const BASE_LINE_WIDTH = 3.0
const DRAW_COLOR = Color('#fff')

func _process(delta):
	for actor in actors:
		actor.get_node("Moves").text = String(actor.moves)
	if level.active_actor != null:
		var actor_map_position = level.active_actor.get_map_position()
		var mouse_map_position = map.world_to_map(get_global_mouse_position())
		path = map.find_path(actor_map_position, mouse_map_position) 
	update()


func _draw():
	# draw selection tile
	var tile_map_position = map.world_to_world(get_global_mouse_position())
	selection.position = tile_map_position
	# draw path
	if not path:
		return
	var start = path[0]
	var end = path[len(path) - 1]
	var end_fixed = map.map_to_world(Vector2(end.x, end.y)) + map.cell_size / 2
	var last = map.map_to_world(Vector2(start.x, start.y)) + map.cell_size / 2
	for index in range(1, len(path)):
		var current = map.map_to_world(Vector2(path[index].x, path[index].y)) + map.cell_size / 2
		draw_line(last, current, DRAW_COLOR, BASE_LINE_WIDTH, true)
		last = current
	draw_circle(end_fixed, BASE_LINE_WIDTH * 2.0, DRAW_COLOR)

#
# P U B L I C   M E T H O D S
#


func draw_marker():
	remove_marker()
	if level.active_actor != null:
		for m in map.get_reachable_tiles(level.active_actor.get_map_position(), level.active_actor.moves):
			m = map.map_to_world_fixed(m)
			add_marker_at(m)


#
# I N T E R N A L   M E T H O D S
#


func add_marker_at(_position):
	var marker = move_marker.instance()
	marker.position = _position
	container.add_child(marker)


func remove_marker():
	var children = container.get_children()
	for c in children:
		c.queue_free()