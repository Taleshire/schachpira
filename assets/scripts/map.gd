extends TileMap

export(int) var width = 9
export(int) var height = 9

var astar = AStar.new()

var obstacles : Array
var tiles : Dictionary


func _ready():
	generate_tiles()
	generate_tile_connections()


#
# P U B L I C   M E T H O D S
#


func find_path(source_map_position : Vector2, destination_map_position : Vector2) -> Array:
	var path3D = astar.get_point_path(flatten(source_map_position), flatten(destination_map_position))
	var path2D = []
	for point in path3D:
		path2D.append(Vector2(point.x, point.y))
	return path2D


func get_reachable_tiles(source_map_position : Vector2, distance : int):
	var reachable = []
	for y in range(height):
		for x in range(width):
			var current_map_position = Vector2(x, y)
			
			if map_to_world_fixed(current_map_position) == position:
				continue
			
			var difference = current_map_position - source_map_position
			if abs(difference.x) + abs(difference.y) > distance:
				continue
			
			if is_tile_blocked(flatten(current_map_position)):
				continue
			
			var path = find_path(source_map_position, current_map_position)
			if path.size() < 1 || path.size() > distance + 1:
				continue
			
			reachable.append(current_map_position)
	print("Reachable: ", reachable)
	return reachable


func block_tile(var id : int) -> void:
	tiles[id].is_blocked = true
	disconnect_with_neighbour_at(id, Vector2( 1,  0))
	disconnect_with_neighbour_at(id, Vector2(-1,  0))
	disconnect_with_neighbour_at(id, Vector2( 0,  1))
	disconnect_with_neighbour_at(id, Vector2( 0, -1))
	print("blocked tile ", id)

func unblock_tile(var id : int) -> void:
	tiles[id].is_blocked = false
	connect_with_neighbour_at(id, Vector2( 1,  0))
	connect_with_neighbour_at(id, Vector2(-1,  0))
	connect_with_neighbour_at(id, Vector2( 0,  1))
	connect_with_neighbour_at(id, Vector2( 0, -1))
	print("unblocked tile ", id)

func is_tile_blocked(var id : int) -> bool:
	return tiles[id].is_blocked


func map_to_world_fixed(map_position : Vector2) -> Vector2:
	return map_to_world(map_position) + Vector2(cell_size.x / 2, cell_size.y / 2)

func world_to_world(world_position : Vector2) -> Vector2:
	return map_to_world(world_to_map(world_position))

func world_to_world_fixed(world_position : Vector2) -> Vector2:
	return map_to_world(world_to_map(world_position)) + Vector2(cell_size.x / 2, cell_size.y / 2)


#
# I N T E R N A L   M E T H O D S
#


func generate_tiles() -> void:
	for y in range(height):
		for x in range(width):
			var id : int = flatten(Vector2(x, y))
			astar.add_point(id, Vector3(x, y, 0))
			tiles[id] = {
				type = get_cell(x, y),
				map_position = Vector2(x, y),
				world_position = map_to_world(Vector2(x, y)),
				cost = 1,
				is_blocked = false,
			}

func generate_tile_connections() -> void:
	for y in range(height):
		for x in range(width):
			var id : int =  flatten(Vector2(x, y))
			var id_position = astar.get_point_position(id)
			var neighbors = {
				u = id_position + Vector3(0, -1, 0),
				d = id_position + Vector3(0,  1, 0),
				r = id_position + Vector3( 1, 0, 0),
				l = id_position + Vector3(-1, 0, 0),
				#ur = id_position + Vector3(1, -1, 0),
				#ul = id_position + Vector3(-1,  -1, 0),
				#dr = id_position + Vector3( 1, 1, 0),
				#dl = id_position + Vector3(-1, 1, 0)
			}
			for n in neighbors.values():
				if check_boundaries(n) && !astar.are_points_connected(id, flatten(Vector2(n.x, n.y))):
					#print("connected ", id, " and ", flatten(n.x, n.y))
					astar.connect_points(id, flatten(Vector2(n.x, n.y)))


func flatten(map_position : Vector2) -> int:
	return int(map_position.y) * width + int(map_position.x);


func check_boundaries(point : Vector3) -> bool:
	return (point.x >= 0 && point.y >= 0 && point.x < width  && point.y < height)


func connect_with_neighbour_at(id : int, offset : Vector2) -> void:
	var cpos = astar.get_point_position(id)
	var p = cpos + Vector3(offset.x, offset.y, 0)
	if check_boundaries(p) && !astar.are_points_connected( id, flatten(Vector2(p.x, p.y)) ):
		if !tiles[id].is_blocked:
			astar.connect_points(id, flatten(Vector2(p.x, p.y)))

func disconnect_with_neighbour_at(id : int, offset : Vector2) -> void:
	var cpos = astar.get_point_position(id)
	var p = cpos + Vector3(offset.x, offset.y, 0)
	if check_boundaries(p) && astar.are_points_connected( id, flatten(Vector2(p.x, p.y)) ):
		astar.disconnect_points(id, flatten(Vector2(p.x, p.y)))


