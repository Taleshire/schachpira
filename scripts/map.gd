extends TileMap

var offset = Vector2(32, 32)

var size = get_used_rect().size
var tiles = {}

var game = null

var camera_start_position = null
var sides = null

onready var token_container = $TokenContainer
onready var token_positions = $PositionContainer.get_children()

# O V E R R I D E

func _ready():
	for y in range(size.y):
		for x in range(size.x):
			var cell = Vector2(x, y)
			var id = _flatten(cell)
			if get_cell(x, y) != 0:
				randomize()
				set_cell(x, y, randi()%5+2)
			tiles[id] = {
					color = get_cellv(cell),
					is_occupied = false
				}

# P U B L I C

func get_mouse_position():
	return world_to_world(get_local_mouse_position())

func get_mouse_cell():
	var mouse_position = get_local_mouse_position()
	return world_to_map(mouse_position)

func world_to_world(_position):
	return map_to_world(world_to_map(_position))

func world_to_world_centered(_position):
	return world_to_world(_position) + offset

func map_to_world_centered(_cell):
	return map_to_world(_cell) + offset

func pattern_to_world_centered(_token):
	var pattern = _token.pattern
	var reachable = []
	for p in pattern:
		var destination = p + world_to_map(_token.position)
		if _check_boundaries(destination) and get_cellv(destination) > 0:
			reachable.append(destination)
	for t in game.get_tokens(game.active_side):
		if get_cellv(world_to_map(t.position)) == get_cellv(game.get_active_token_cell()):
			reachable.append(world_to_map(t.position))
	return reachable

func get_camera_start_position():
	return map_to_world_centered(camera_start_position)

func get_next_start_position(_side):
	for p in token_positions:
		if p.side == _side and p.is_free:
			return p
	return null

func get_cell_color():
	return get_cellv(get_mouse_cell())

func get_side_count():
	return sides

# P R I V A T E

func _flatten(_cell):
	return int(_cell.y) * size.x + int(_cell.x)

func _check_boundaries(_point):
	return (_point.x >= 0 and _point.y >= 0 and _point.x < size.x  and _point.y < size.y)
