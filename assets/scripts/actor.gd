extends Node2D

onready var map = get_node("../../Map")
onready var draw = get_node("../../UI/Draw")
onready var level = get_node("../..")

var speed : int = 300

export(int) var HEALTH_MAX = 8
export(int) var MOVES_MAX = 4
export(int) var INIT_MAX = 5
export(int) var STRENGTH_MAX = 2
export(int) var ATTACK_RANGE = 1

var health : int
var moves : int
var init : int
var strength : int

var can_move : bool = true
var can_attack : bool = true

var is_moving : bool = false
var is_attacking : bool = false

var path : PoolVector2Array setget set_path

func _ready():
	health = HEALTH_MAX
	moves = MOVES_MAX
	init = INIT_MAX
	strength = STRENGTH_MAX


func _process(delta):
	if path.size() > 0 and moves > 0 and is_moving:
		map.unblock_tile(map.flatten(map.world_to_map(position)))
		var distance = position.distance_to(next_in_path())
		if distance > 4:
			set_position(position.linear_interpolate(next_in_path(), (speed * delta)/distance))
		else:
			print(path)
			moves = moves - 1
			path.remove(0)
			draw.draw_marker()
			if path.size() == 0:
				is_moving = false
				set_position(map.world_to_world_fixed(position))
				level.active_actor = null
	elif path.size() > 0 and moves == 0:
		print(path)
		set_position(map.world_to_world_fixed(position))
		print(position)
		is_moving = false

#
# P U B L I C   M E T H O D S
#


func get_map_position() -> Vector2:
	return map.world_to_map(position)


func turn_end():
	moves = MOVES_MAX
	can_move = true
	can_attack = true


func reduce_sprite():
	scale.x = 0.8
	scale.y = 0.8


func enlarge_sprite():
	scale.x = 1
	scale.y = 1


#
# INTERNAL METHODS
#


func next_in_path() -> Vector2:
	return map.map_to_world_fixed((path[0]))


func set_path(_path : PoolVector2Array) -> void:
	path = _path
	path.remove(0)
	is_moving = true