extends Node2D

var map
var tokens

var active_side setget _set_active_side
var active_token setget _set_active_token
var active_token_path : Array = []

var is_selection_locked : bool


onready var move_handler = $Handler/Move

onready var map_container = $MapContainer
onready var token_container = $TokenContainer

onready var draw = $Draw
onready var camera = $Camera

func _ready():
	_load_map()
	_load_tokens()
	move_handler.map = map
	move_handler.match_ = self
	draw.match_ = self
	tokens = token_container.get_children()
	camera.position = map.get_camera_start_position()
	_set_active_side(1)
	
var click_left
var click_right

func _input(event):
	var click_left = Input.is_action_just_pressed("click_left")
	var click_right = Input.is_action_just_pressed("click_right")
	if event is InputEventMouseButton:
		if click_left and not is_selection_locked:
			var mouse_cell = map.get_mouse_cell()
			print(mouse_cell)
			if active_token and !_is_token_at_cell(mouse_cell):
				if !_should_move(mouse_cell):
					var path : Array
					if active_token_path.empty():
						path = map.find_path_by_cell(_get_active_token_cell(), mouse_cell)
						_add_to_active_token_path(path)
					else:
						path = map.find_path_by_cell(_get_last_path_point(), mouse_cell)
						_add_to_active_token_path(path)
				elif active_token.has_actions_left():
					move_handler.move_token(active_token, active_token_path)
			else:
				var token = _get_token_at_cell(mouse_cell)
				if _is_token_at_cell(mouse_cell, active_side) and token.has_actions_left():
					_set_active_token(token)
		
		if click_right and not is_selection_locked:
			_set_active_token(null)

func _process(delta):
	draw.draw_selection()
	if active_token and not is_selection_locked:
		if map._check_boundaries(map.get_mouse_cell()) and active_token.has_actions_left():
			var additional_path = map.find_path_by_cell(_get_last_path_point(), map.get_mouse_cell())
			var draw_path = active_token_path + additional_path
			draw.draw_path(draw_path, active_token.actions)

# P U B L I C   F U N C T I O N S

func get_reachable_cells(_token : Sprite) -> Array:
	var cell = map.world_to_map(_token.position)
	return map.get_reachable_cells(cell, _token.actions)

# P R I V A T E   F U N C T I O N S

func _load_tokens():
	for t in global.token_ids:
		var p = map.get_next_start_position(t[0])
		if !p:
			continue
		var token = t[1]
		_place_token(token, p.SIDE, p)

func _place_token(var _id : String, _side : int,  _position : Position2D):
	var token = global.tokens[_id].scene.instance()
	token.side = _side
	token.position = _position.position
	_position.is_free = false
	map.block_cell(map.world_to_map(_position.position))
	
	token_container.add_child(token)
	print("Token: ", _id, " at ", _position, " for side ", _side)

func _load_map() -> void:
	map = global.maps[global.map_id].scene.instance()
	print(global.map_id, " loaded")
	map_container.add_child(map)


func _is_token_at_cell(_cell : Vector2, _side = 0) -> bool:
	for t in tokens:
		if t.position == map.map_to_world_centered(_cell):
			if _side == 0:
				return true
			else:
				if t.side == _side:
					return true
	return false

func _get_token_at_cell(_cell : Vector2) -> Sprite:
	for t in tokens:
		if t.position == map.map_to_world_centered(_cell):
			return t
	return null

func _get_active_token_cell():
	if active_token:
		return map.world_to_map(active_token.position)
	return null


func _center_position(_node : Node):
	_node.position = map.world_to_world_centered(_node.position)


func _should_move(_cell):
	if active_token_path.empty():
		return false
	else:
		if active_token_path[active_token_path.size() - 1] == _cell:
			return true
	return false

func _get_last_path_point() -> Vector2:
	if active_token_path.size() == 0:
		return _get_active_token_cell()
	else:
		return active_token_path[active_token_path.size() - 1]

func _add_to_active_token_path(_path : Array):
	var path_size = active_token_path.size() + _path.size()
	if active_token.actions < path_size:
		return
	var actions = active_token.actions - path_size
	print("Path Size: ", path_size)
	print("Actions Left: ", actions)
	for point in _path:
		print(point)
		active_token_path.append(point)
	var cell = active_token_path[path_size-1]
	draw.draw_move_marker(map.get_reachable_cells(cell, actions))
	print(active_token_path)

func _clear_active_token_path():
	active_token_path = []


func _get_tokens_from_side(_side : int) -> Array:
	var side_tokens = []
	for token in tokens:
		if token.side == _side:
			side_tokens.append(token)
	return side_tokens


# S E T T E R

func _set_active_token(_token):
	if active_token:
		active_token.reduce()
		map.block_cell(_get_active_token_cell())
	active_token = _token
	print("Token changed: ", active_token)
	if active_token:
		map.unblock_cell(_get_active_token_cell())
		active_token.enlarge()
		draw.draw_move_marker(map.get_reachable_cells_t(active_token))
		print("Actions Left: ", active_token.actions)
	else:
		_clear_active_token_path()
		draw.clear_path_marker()
		draw.clear_move_marker()

func _set_active_side(_side):
	active_side = _side
	var side_tokens = _get_tokens_from_side(_side)
	for t in side_tokens:
		t.turn_end()

# O N   S I G N A L   F U N C T I O N S

func _on_move_path_changed():
	active_token.actions -= 1
	print("Checkpoint Reached")
	print("Actions Left: ", active_token.actions)

func _on_move_token_arrived():
	draw.clear_move_marker()
	draw.clear_path_marker()
	map.block_cell(_get_active_token_cell())
	_set_active_token(null)
	is_selection_locked = false
	print("Token Stoppen Moving")

func _on_move_token_started():
	draw.clear_path_marker()
	draw.clear_move_marker()
	is_selection_locked = true
	print("Token Started Moving")
	print("Actions Left: ", active_token.actions)

func _on_turn_end_pressed():
	_set_active_side(active_side + 1)
	if active_side > map.SIDES:
		_set_active_side(1)
	print("Turn Side ", active_side)
