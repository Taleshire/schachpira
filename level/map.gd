extends TileMap

export(int) var width = 8
export(int) var height = 8

var start_position : Vector2 setget set_start_position
var end_position : Vector2 setget set_end_position

var obstacles : Array
var path : PoolVector2Array

var tiles : Dictionary

func _ready():
	for y in range(height):
		for x in range(width):
			tiles[y * width + x] = {
				type = get_cell(x, y),
				map_position = Vector2(x, y),
				world_position = map_to_world(Vector2(x, y)),
				cost = 1,
				is_occupied = false,
				neighbors = {
					cardinal = {
						u = Vector2(x, y-1),
						d = Vector2(x, y+1),
						r = Vector2(x+1, y),
						l = Vector2(x-1, y)
					},
					diagonal = {
						ur = Vector2(x+1, y-1),
						ul = Vector2(x-1, y-1),
						dr = Vector2(x+1, y+1),
						dl = Vector2(x-1, y+1)
					}	
				}
			}

func _input(event):
	if Input.is_action_just_pressed("click_left"):
		var map_position = world_to_map(get_global_mouse_position())
		#print(tiles[calculate_tile_index(map_position)])

func calculate_tile_index(map_position : Vector2) -> int:
	return int(map_position.y) * width + int(map_position.x);

func get_tile_at_mouse_position():
	return map_to_world(world_to_map(get_global_mouse_position()))

func set_start_position(position : Vector2):
	start_position = position

func set_end_position(position : Vector2):
	end_position = position




