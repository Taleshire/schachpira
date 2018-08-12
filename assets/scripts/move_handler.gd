extends Node

signal token_started
signal token_arrived
signal path_changed

const SPEED = Vector2(300, 300)

var match_
var map

var path : Array = []
var token : Sprite

var last_point : Vector2

func _ready():
	set_process(true)
	pass

func _process(delta):
	if path.size() != 0 and token:
		var direction = _get_move_direction()
		var velocity = direction * SPEED * delta
		print(velocity)
		token.position += velocity.floor()
		if token.position * direction > map.map_to_world_centered(path[0]) * direction:
			emit_signal("path_changed")
			last_point = path[0]
			path.remove(0)
			match_._center_position(token)
			if path.size() == 0:
				token = null
				emit_signal("token_arrived")


# P U B L I C   F U N C T I O N S

func move_token_by_cell(_token : Sprite, _end_cell : Vector2 ):
	var start_cell = map.world_to_map(_token.position)
	path = map.find_path_by_cell(start_cell, _end_cell)
	print(path)
	if path.size() > 1:
		token = _token
		last_point = start_cell
		path.remove(0)
		emit_signal("token_started")
	pass

# P R I V A T E   F U N C T I O N S

func _get_move_direction() -> Vector2:
	return path[0] - last_point

func _set_map(_map):
	map = _map
