extends Sprite

var pattern = []
var side = 1 setget _set_side
var is_king = false

# O V E R R I D E 

func _ready():
	pass

# P U B L I C

func can_move_to(_cell):
	var map = $"../.."
	var position_cell = map.world_to_map(position)
	print("Position Cell", position_cell)
	for p in pattern:
		print(position_cell + p)
		if position_cell + p == _cell:
			return true
	return false

func move_to(_position):
	rpc("_update_position", _position)

func remove():
	rpc("_remove")

sync func _remove():
	print("Remove Token: ", name)
	queue_free()

sync func _update_position(_position):
	position = _position

func get_pattern_tiles():
	return pattern

func reduce():
	scale = Vector2(1, 1)

func enlarge():
	scale = Vector2(1.1, 1.1)

func flip_token():
	var new_pattern = []
	for p in pattern:
		new_pattern.append(p * -1)
	pattern = new_pattern
	flip_v = !flip_v
	flip_h = !flip_h

func _set_side(_side):
	side = _side
	if _side == 1:
		$TC.texture = textures.tc.red
	if _side == 2:
		$TC.texture = textures.tc.blue
		flip_token()
	if _side == 3:
		$TC.texture = textures.tc.green
	if _side == 4:
		$TC.texture = textures.tc.violet
		flip_token()
	