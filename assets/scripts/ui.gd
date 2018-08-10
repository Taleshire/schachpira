extends Control

onready var level = get_node("../..")
onready var map = get_node("../../Map")
onready var selection = get_node("Selection")
onready var container = get_node("MarkerContainer")
onready var actors = get_node("../../Actors").get_children()

var move_marker = preload("res://assets/scenes/Marker.tscn")

func _process(delta):
	for actor in actors:
		actor.get_node("Moves").text = String(actor.moves)
	update()


func _draw():
	var tile_map_position = map.world_to_world(get_global_mouse_position())
	selection.position = tile_map_position


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