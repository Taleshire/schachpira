extends Node2D

onready var map = get_node("../../Map")
onready var draw = get_node("../../UI/Draw")
onready var level = get_node("../..")

enum STATES {IDLE, MOVE, FIGHT}

var speed : int = 250
var direction : Vector2

export(int) var HEALTH_MAX = 8
export(int) var MOVES_MAX = 4
export(int) var STRENGTH_MAX = 2
export(int) var ATTACK_RANGE = 1
export(int) var SIDE = 1

var health : int
var moves : int
var strength : int
var honor : int = 0

var can_move : bool = true
var can_attack : bool = true

var is_moving : bool = false
var is_attacking : bool = false

var path : PoolVector2Array setget set_path

func _ready():
	health = HEALTH_MAX
	moves = MOVES_MAX
	strength = STRENGTH_MAX


func _process(delta):
	handle_movement(delta)

#
# P U B L I C   M E T H O D S
#

func get_move_direction() -> Vector2:
	return path[0] - get_map_position()


func get_map_position() -> Vector2:
	return map.world_to_map(position)


func turn_end():
	moves = MOVES_MAX
	honor = honor + 1
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
func checkpoint_reached():
	moves -= 1
	path.remove(0)
	if path.size() == 0:
		draw.draw_marker()
		is_moving = false
		set_position(map.world_to_world_fixed(position))
		level.active_actor = null
	else:
		direction = get_move_direction()


func handle_movement(delta):
	if path.size() > 0 and moves > 0 and is_moving:
		map.unblock_tile(map.flatten(map.world_to_map(position)))
		if can_move:
			direction = get_move_direction()
			can_move = false
		var velocity = direction * speed * delta
		position += velocity
		print(velocity)
		if position * direction > map.map_to_world_fixed(path[0]) * direction:
			checkpoint_reached()
	elif path.size() > 0 and moves == 0:
		print(path)
		set_position(map.world_to_world_fixed(position))
		print(position)
		is_moving = false


func next_in_path() -> Vector2:
	return map.map_to_world_fixed((path[0]))


func set_path(_path : PoolVector2Array) -> void:
	path = _path
	path.remove(0)
	is_moving = true