extends Node2D

var map
var tokens

var active_token setget _set_active_token
var active_token_path : Array = []

var click_left
var click_right

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
	
func _input(event):
	var click_left = Input.is_action_just_pressed("click_left")
	var click_right = Input.is_action_just_pressed("click_right")
	if event is InputEventMouseButton:
		if click_left and not is_selection_locked:
			var mouse_cell = map.get_mouse_cell()
			if active_token and !_is_token_at_cell(mouse_cell):
				if !_should_move(mouse_cell):
					var path : Array
					if active_token_path.empty():
						path = map.find_path_by_cell(_get_active_token_cell(), mouse_cell)
						_add_to_active_token_path(path)
					else:
						path = map.find_path_by_cell(_get_last_path_point(), mouse_cell)
						_add_to_active_token_path(path)
				else:
					move_handler.move_token(active_token, active_token_path)
			else:
				_set_active_token(_get_token_at_cell(mouse_cell))
		if click_right  and not is_selection_locked:
			_set_active_token(null)

func _process(delta):
	draw.draw_selection()
	if active_token and not is_selection_locked:
		var aditional_path = map.find_path_by_cell(_get_last_path_point(), map.get_mouse_cell())
		aditional_path.remove(0)
		var draw_path = active_token_path + aditional_path
		draw.draw_path(draw_path, active_token.actions)

# P U B L I C   F U N C T I O N S

func get_reachable_cells(_token : Sprite) -> Array:
	var cell = map.world_to_map(_token.position)
	return map.get_reachable_cells(cell, _token.actions)

# P R I V A T E   F U N C T I O N S

func _load_tokens():
	var positions = map.start_positions
	for t in global.token_ids:
		var p = map.get_next_start_position(t[0])
		if !p:
			continue
		var token = t[1]
		_place_token(token, p.SIDE, p)

func _place_token(var _id : String, _side : int,  _position : Position2D):
	var token = global.tokens[_id].scene.instance()
	token.SIDE = _side
	token.position = _position.position
	_position.is_free = false
	map.block_cell(map.world_to_map(_position.position))
	
	token_container.add_child(token)
	print("Token: ", _id, " at ", _position, " for side ", _side)

func _load_map() -> void:
	map = global.maps[global.map_id].scene.instance()
	print(global.map_id, " loaded")
	map_container.add_child(map)


func _is_token_at_cell(_cell : Vector2) -> bool:
	for t in tokens:
		if t.position == map.map_to_world_centered(_cell):
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
	else:
		_clear_active_token_path()
		draw.clear_path_marker()
		draw.clear_move_marker()


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
	if active_token_path:
		_path.remove(0)
	var path_size = active_token_path.size() + _path.size() - 1
	var actions = active_token.actions - path_size
	print("Path Size: ", path_size)
	print("Actions Left: ", actions)
	if active_token.actions < path_size:
		return
	for point in _path:
		print(point)
		active_token_path.append(point)
	var cell = active_token_path[path_size]
	draw.draw_move_marker(map.get_reachable_cells(cell, actions))
	print(active_token_path)

func _clear_active_token_path():
	active_token_path = []


func _on_move_path_changed():
	active_token.actions -= 1
	#draw.draw_move_marker(map.get_reachable_cells_t(active_token))

func _on_move_token_arrived():
	draw.clear_move_marker()
	draw.clear_path_marker()
	map.block_cell(_get_active_token_cell())
	is_selection_locked = false
	_set_active_token(null)

func _on_move_token_started():
	is_selection_locked = true
