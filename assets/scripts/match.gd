extends Node2D

var map
var tokens

var active_token setget _set_active_token

var is_selection_locked

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
	if Input.is_action_just_pressed("click_left") and not is_selection_locked:
		var cell = map.get_mouse_cell()
		if active_token and !_is_token_at_cell(cell):
			move_handler.move_token_by_cell(active_token, cell)
		else:
			_set_active_token(_get_token_at_cell(cell))
	if Input.is_action_just_pressed("click_right")  and not is_selection_locked:
		_set_active_token(null)

func _process(delta):
	# DRAW SELECTION
	draw.draw_selection()
	# DRAW PATH
	if active_token:
		var path = map.find_path_by_position(active_token.position, map.get_mouse_position())
		draw.draw_path(path)
		print(path)

# P U B L I C   F U N C T I O N S

func get_reachable_cells(_token : Sprite) -> Array:
	var cell = map.world_to_map(_token.position)
	return map.get_reachable_cells(cell, _token.actions)

# P R I V A T E   F U N C T I O N S

func _load_tokens():
	var positions = map.start_positions
	for i in range(positions.size()):
		var p = positions[i]
		var t = global.token_ids[i]
		_load_token(t, p.SIDE, p.position)

func _load_token(var _id : String, _side : int,  _position : Vector2):
	var token = global.tokens[_id].scene.instance()
	token.SIDE = _side
	token.position = _position
	map.block_cell(map.world_to_map(_position))
	print("Token: ", _id, " at ", _position, " for side ", _side)
	token_container.add_child(token)

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
		draw.clear_path_marker()
		draw.clear_move_marker()
	

func _on_move_path_changed():
	active_token.actions -= 1
	draw.draw_move_marker(map.get_reachable_cells_t(active_token))

func _on_move_token_arrived():
	draw.clear_move_marker()
	draw.clear_path_marker()
	map.block_cell(_get_active_token_cell())
	is_selection_locked = false
	_set_active_token(null)


func _on_move_token_started():
	is_selection_locked = true
