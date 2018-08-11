extends Control

onready var level = get_node("../..")
onready var map = get_node("../../Map")
onready var selection = get_node("Selection")
onready var container = get_node("MarkerContainer")
onready var tile = get_node("Tile")
onready var actors = get_node("../../Actors").get_children()
onready var turn_end = get_node("TurnEnd")
onready var turn = get_node("Turn")

onready var health = get_node("ActiveActor/Health")
onready var moves = get_node("ActiveActor/Moves")
onready var honor = get_node("ActiveActor/Honor")
onready var strength = get_node("ActiveActor/Strength")

var move_marker = preload("res://assets/scenes/Marker.tscn")

var path : Array

const BASE_LINE_WIDTH = 3.0
const DRAW_COLOR = Color('#fff')


func _ready():
	turn.text = str("Turn: ", level.turn)
	turn_end.text = String("Turn End")


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
	var tile_position = map.world_to_world(get_global_mouse_position())
	selection.position = tile_position
	tile.text = String(selection.position)
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


func draw_actor_stats():
	if level.active_actor != null:
		health.text = str("Health: ", level.active_actor.health)
		moves.text = str("Moves: ", level.active_actor.moves)
		honor.text = str("Honor: ", level.active_actor.honor)
		strength.text = str("Strength: ", level.active_actor.strength)
	else:
		health.text = str("Health: -")
		moves.text = str("Moves: -")
		honor.text = str("Honor: -")
		strength.text = str("Strength: -")


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


func _on_TurnEnd_button_up():
	turn.text = String("Turn: ") + String(level.turn) 
