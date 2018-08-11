extends Node2D

onready var map = get_node("Map")
onready var actors = get_node("Actors").get_children()
onready var draw = get_node("UI/Draw")

var active_actor = null setget set_active_actor


func _ready():
	for actor in actors:
		map.block_tile(map.flatten(map.world_to_map(actor.get_position())))
		print(actor.name, ": ", actor.get_position())
	set_process_input(true)


var is_left_clicked = false
var is_right_clicked = false
func _input(event):
	if Input.is_action_just_pressed("click_left") and !is_left_clicked:
		is_left_clicked = true
		var mouse_position = get_global_mouse_position()
		var destination_fixed = map.world_to_world_fixed(mouse_position)
		var destination = map.world_to_world(mouse_position)
		if is_actor_at_position(destination_fixed):	
			set_active_actor(get_actor_at_position(destination_fixed))
			draw.draw_marker()
		elif active_actor != null and !is_actor_at_position(destination_fixed):
			handle_active_actor_path(destination)
	if Input.is_action_just_pressed("click_right") and active_actor != null and !is_right_clicked:
		is_right_clicked = true
		set_active_actor(null)
		draw.remove_marker()
	if Input.is_action_just_released("click_left"):
		is_left_clicked = false
	if Input.is_action_just_released("click_right"):
		is_right_clicked = false

#
# P U B L I C   M E T H O D S
#

#
# I N T E R N A L   M E T H O D S
#

func get_actor_at_position(destination):
	for actor in actors:
		if actor.position == destination:
			return actor


func is_actor_at_position(destination):
	for actor in actors:
		if actor.position == destination:
			return true
	return false

func handle_active_actor_path(destination):
	if active_actor != null:
		var actor_map_position = active_actor.get_map_position()
		var destination_map_position = map.world_to_map(destination)
		var path = map.find_path(actor_map_position, destination_map_position)
		active_actor.path = path


func set_active_actor(new_actor):
	draw.remove_marker()
	draw.path = []
	if active_actor != null:
		active_actor.reduce_sprite()
		map.block_tile(map.flatten(active_actor.get_map_position()))
	active_actor = new_actor
	print("Actor changed!: ", active_actor)
	if active_actor != null:
		active_actor.enlarge_sprite()
		map.unblock_tile(map.flatten(active_actor.get_map_position()))