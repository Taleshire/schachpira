extends Node2D

signal game_finished

var player_side = 1
var map = global.maps["standard_2"].scene.instance()
sync var tokens = []

var active_token = null
sync var active_side = 1

onready var map_container = $MapContainer
onready var draw = $Interface/Draw
onready var game_over = $Interface/GameOver

func _ready():
	_load_map()
	_load_tokens()
	tokens = map.token_container.get_children()
	$Interface/Draw.game = self
	if get_tree().is_network_server():
		for t in tokens:
			if t.side == 2:
				t.set_network_master(get_tree().get_network_connected_peers()[0])
	else:
		player_side = 2
		for t in tokens:
			if t.side == 2:
				t.set_network_master(get_tree().get_network_unique_id())
	print("Player: ", player_side,  ", GAME READY!")

var click_left
var click_right

func _input(event):
	click_left = Input.is_action_just_pressed("click_left")
	click_right = Input.is_action_just_pressed("click_right")
	
	if event is InputEventMouseButton and active_side == player_side:
		if click_left:
			var mouse_cell = map.get_mouse_cell()
			print("Mouse Cell: ", mouse_cell)
			if active_token and !_is_token_at_cell(mouse_cell):
				if active_token.can_move_to(mouse_cell):
					active_token.move_to(map.map_to_world_centered(mouse_cell))
					rpc("_next_side")
					rpc("_set_active_token", null)
			elif active_token and _is_token_at_cell(mouse_cell):
				var token = _get_token_at_cell(mouse_cell)
				if token.side == active_token.side:
					if _is_same_cell_color(get_active_token_cell(), mouse_cell):
						if token != active_token:
							var temp_position = active_token.position
							active_token.move_to(token.position)
							token.move_to(temp_position)
							rpc("_next_side")
							rpc("_set_active_token", null)
				else:
					if active_token.side != token.side and active_token.can_move_to(mouse_cell):
						active_token.move_to(token.position)
						if token.is_king:
							rpc("_game_over")
						token.remove()
						print("Token Removed. Tokens Left: ", tokens.size())
						rpc("_next_side")
						rpc("_set_active_token", null)
					else:
						print("Not Your Turn!")
			else:
				var token = _get_token_at_cell(mouse_cell)
				if _is_token_at_cell(mouse_cell, active_side):
					rpc("_set_active_token", token)
		
		elif click_right:
			rpc("_set_active_token", null)
			pass

# P R I V A T E

func _load_tokens():
	for t in global.token_ids:
		var p = map.get_next_start_position(t[0])
		if !p:
			continue
		var token = t[1]
		_place_token(token, p.side, p)

func _place_token(var _id, _side,  _position):
	var token = global.tokens[_id].scene.instance()
	token.is_king = global.tokens[_id].is_king
	token.pattern = global.tokens[_id].pattern
	token.side = _side
	token.position = _position.position
	_position.is_free = false
	
	map.token_container.add_child(token)
	print("Token: ", _id, " at ", _position, " for side ", _side)

func _load_map():
	map = global.maps[global.map_id].scene.instance()
	map.camera_start_position = global.maps[global.map_id].camera_start_position
	map.sides = global.maps[global.map_id].sides
	map.game = self
	print(global.map_id, " loaded")
	map_container.add_child(map)

func _is_same_cell_color(_cell_1, _cell_2):
	var type_1 = map.get_cellv(_cell_1)
	var type_2 = map.get_cellv(_cell_2)
	if type_1 == type_2:
		return true
	return false

func _is_token_at_cell(_cell, _side = 0):
	tokens = map.token_container.get_children()
	for t in tokens:
		if t.position == map.map_to_world_centered(_cell):
			if _side == 0:
				return true
			else:
				if t.side == _side:
					return true
	return false

func get_active_token_cell():
	if active_token:
		return map.world_to_map(active_token.position)
	return null

func _get_token_at_cell(_cell):
	tokens = map.token_container.get_children()
	for t in tokens:
		if t.position == map.map_to_world_centered(_cell):
			return t
	return null

func get_tokens(_side = 0):
	tokens = map.token_container.get_children()
	var side_tokens = []
	if _side == 0:
		return tokens
	else:
		for t in tokens:
			if t.side == _side:
				side_tokens.append(t)
	return side_tokens

sync func _set_active_token(_token):
	if active_token:
		active_token.reduce()
	active_token = _token
	print("Token changed: ", active_token)
	if active_token:
		active_token.enlarge()
		var reachable = map.pattern_to_world_centered(active_token)
		print(reachable)
		draw.draw_move_marker(reachable)
	else:
		draw.clear_move_marker()

sync func _game_over():
	game_over.label.text = str("PLAYER ", active_side, " WINS!")
	game_over.show()

sync func _next_side():
	active_side = ((active_side) % map.sides) + 1
	print("Next Side: ", active_side)