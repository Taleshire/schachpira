extends TileMap

export(int) var WIDTH : int = 15
export(int) var HEIGHT : int = 17
export(Vector2) var CAMERA : Vector2 = Vector2(0, 0)

var offset = Vector2(cell_size.x / 2, cell_size.y / 2)

var tiles : Dictionary 
var grid : AStar = AStar.new()

onready var start_positions = get_children()


# V I R T U A L   F U N C T I O N S

func _init():
	_generate_tiles()
	_generate_points()
	_generate_point_connections()

# P U B L I C   F U N C T I O N S

func find_path_by_position(_start_position : Vector2, _end_position : Vector2) -> Array:
	var start_cell = world_to_map(_start_position)
	var end_cell = world_to_map(_end_position)
	return find_path_by_cell(start_cell, end_cell)

func find_path_by_cell(_start_cell : Vector2, _end_cell : Vector2) -> Array:
	var path3D = grid.get_point_path(_flatten_v(_start_cell), _flatten_v(_end_cell))
	var path2D = []
	for point in path3D:
		path2D.append(Vector2(point.x, point.y))
	return path2D

func get_reachable_cells_t(_token : Sprite) -> Array:
	var reachable = get_reachable_cells(world_to_map(_token.position), _token.actions)
	return reachable

func get_reachable_cells(_start_cell: Vector2, _range : int) -> Array:
	var reachable = []
	for cell in get_used_cells():
		var path = find_path_by_cell(_start_cell, cell)
		if path.size() < 2 or path.size() > _range:
			continue
		reachable.append(cell)
	return reachable

func unblock_cell(_cell : Vector2) -> void:
	_connect_with_cardinal_neighbors(_cell)

func block_cell(_cell : Vector2) -> void:
	_disconnect_with_cardinal_neighbors(_cell)

func get_mouse_cell() -> Vector2:
	var mouse_position = get_local_mouse_position()
	return world_to_map(mouse_position)

func get_mouse_position() -> Vector2:
	return get_local_mouse_position()

func get_cell_difference(_cell) -> Vector2:
	return get_mouse_cell() - _cell

func world_to_world_centered(_position : Vector2) -> Vector2:
	return world_to_world(_position) + offset

func world_to_world(_position : Vector2) -> Vector2:
	return map_to_world(world_to_map(_position))

func map_to_world_centered(_cell : Vector2) -> Vector2:
	return map_to_world(_cell) + offset

func get_camera_start_position() -> Vector2:
	return map_to_world_centered(CAMERA)

func get_start_positions(_side: int) -> Array:
	var positions : Array = []
	for p in start_positions:
		if start_positions.SIDE == _side:
			positions.append(p)
	return positions

func get_next_start_position(_side : int) -> Position2D:
	for p in start_positions:
		if p.SIDE == _side and p.is_free:
			return p
	return null

# P R I V A T E   F U N C T I O N S

func _generate_tiles() -> void:
	for cell in get_used_cells():
		var id = _flatten_v(cell)
		tiles[id] = {
				cell = cell,
				weight = 1,
				is_blocked = false,
			}
	_block_border_tiles()

func _block_border_tiles():
	for cell in get_used_cells():
		var id = _flatten_v(cell)
		if get_cell(cell.x, cell.y) == 0:
			tiles[id].is_blocked = true

func _generate_points() -> void:
	for cell in get_used_cells():
		var id = _flatten_v(cell)
		grid.add_point(id, Vector3(cell.x, cell.y, 0))

func _generate_point_connections() -> void:
	for cell in get_used_cells():
		var id = _flatten_v(cell)
		var point = grid.get_point_position(id)
		_connect_with_cardinal_neighbors(cell)

func _connect_with_cardinal_neighbors(_cell : Vector2) -> void:
	var id = _flatten_v(_cell)
	var neighbors = _get_cardinal_neighbors(_cell)
	for n in neighbors:
		var n_id = _flatten(n.x, n.y)
		if _check_boundaries(n) and !grid.are_points_connected(id, n_id):
			if !tiles[id].is_blocked and !tiles[n_id].is_blocked:
				grid.connect_points(id, n_id)

func _disconnect_with_cardinal_neighbors(_cell : Vector2) -> void:
	var id = _flatten_v(_cell)
	var neighbors = _get_cardinal_neighbors(_cell)
	for n in neighbors:
		var n_id = _flatten(n.x, n.y)
		if _check_boundaries(n) and grid.are_points_connected(id, n_id):
			grid.disconnect_points(id, n_id)


func _get_all_neighbors(_cell : Vector2) -> Array:
	var cardinal : Array = _get_cardinal_neighbors(_cell)
	var diagonal : Array = _get_diagonal_neighbors(_cell)
	return cardinal + diagonal

func _get_cardinal_neighbors(_cell : Vector2) -> Array:
	var cube = Vector3(_cell.x, _cell.y, 0)
	var neighbors : Array = []
	neighbors.append(cube + Vector3(0, -1, 0))
	neighbors.append(cube + Vector3(0,  1, 0))
	neighbors.append(cube + Vector3( 1, 0, 0))
	neighbors.append(cube + Vector3(-1, 0, 0))
	return neighbors

func _get_diagonal_neighbors(_cell : Vector2) -> Array:
	var cube = Vector3(_cell.x, _cell.y, 0)
	var neighbors : Array = []
	neighbors.append(cube + Vector3(1, -1, 0))
	neighbors.append(cube + Vector3(-1,  -1, 0))
	neighbors.append(cube + Vector3( 1, 1, 0))
	neighbors.append(cube + Vector3(-1, 1, 0))
	return neighbors

func _flatten_v(_cell: Vector2) -> int:
	return int(_cell.y) * WIDTH + int(_cell.x)

func _flatten(_x : int, _y : int) -> int:
	return _y * WIDTH + _x
	
func _check_boundaries(_point : Vector3) -> bool:
	return (_point.x >= 0 and _point.y >= 0 and _point.x < WIDTH  and _point.y < HEIGHT)