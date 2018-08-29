extends Node

var map_id
var token_ids

var maps = {}
var tokens = {}

func _ready():
	_fill_map_dictionary()
	_fill_token_dictionary()

# P U B L I C

func new_game(_map, _tokens):
	map_id = _map
	token_ids = _tokens
	print("NEW MATCH")

# P R I V A T E

func _fill_map_dictionary():
	maps["standard_2"] = {
		scene = preload("res://scenes/maps/Standard_2.tscn"),
		sides = 2,
		camera_start_position = Vector2(4, 4)
	}

func _fill_token_dictionary():
	tokens["00"] = {
		scene = preload("res://scenes/tokens/00.tscn"),
		pattern = [
			Vector2(-2, -2),
			Vector2(2, -2),
			Vector2(-1, 0),
			Vector2(1, 0),
			Vector2(-2, 2),
			Vector2(2, 2)],
		is_king = true
	}
	tokens["01"] = {
		scene = preload("res://scenes/tokens/01.tscn"),
		pattern = [
			Vector2(0, -2),
			Vector2(0, -1),
			Vector2(-2, 0),
			Vector2(2, 0),
			Vector2(0, 1),
			Vector2(0, 2)],
		is_king = true
	}
	tokens["02"] = {
		scene = preload("res://scenes/tokens/02.tscn"),
		pattern = [
			Vector2(-2, -2),
			Vector2(2, -2),
			Vector2(-1, -1),
			Vector2(1, 1),
			Vector2(-2, 2),
			Vector2(2, 2)],
		is_king = true
	}
	tokens["03"] = {
		scene = preload("res://scenes/tokens/03.tscn"),
		pattern = [
			Vector2(-2, -2),
			Vector2(2, -2),
			Vector2(1, -1),
			Vector2(-1, 1),
			Vector2(-2, 2),
			Vector2(2, 2)],
		is_king = true
	}
	tokens["04"] = {
		scene = preload("res://scenes/tokens/04.tscn"),
		pattern = [
			Vector2(0, -2),
			Vector2(0, -1),
			Vector2(-2, 0),
			Vector2(2, 0),
			Vector2(0, 1),
			Vector2(0, 2)],
		is_king = true
	}
	tokens["05"] = {
		scene = preload("res://scenes/tokens/05.tscn"),
		pattern = [
			Vector2(0, -2),
			Vector2(1, -1),
			Vector2(-2, 0),
			Vector2(2, 0),
			Vector2(-1, 1),
			Vector2(0, 2)],
		is_king = true
	}
	tokens["06"] = {
		scene = preload("res://scenes/tokens/06.tscn"),
		pattern = [
			Vector2(-1, -2),
			Vector2(1, -2),
			Vector2(0, -1),
			Vector2(0, 1)],
		is_king = false
	}
	tokens["07"] = {
		scene = preload("res://scenes/tokens/07.tscn"),
		pattern = [
			Vector2(-2, -1),
			Vector2(-2, 1),
			Vector2(-1, 1),
			Vector2(1, 1)],
		is_king = false
	}
	tokens["08"] = {
		scene = preload("res://scenes/tokens/08.tscn"),
		pattern = [
			Vector2(0, -2),
			Vector2(-2, -1),
			Vector2(1, 0),
			Vector2(1, 1)],
		is_king = false
	}
	tokens["09"] = {
		scene = preload("res://scenes/tokens/09.tscn"),
		pattern = [
			Vector2(0, -2),
			Vector2(2, -1),
			Vector2(-1, 0),
			Vector2(-1, 1)],
		is_king = false
	}
	tokens["10"] = {
		scene = preload("res://scenes/tokens/10.tscn"),
		pattern = [
			Vector2(-2, -2),
			Vector2(2, -1),
			Vector2(1, 0),
			Vector2(-1, 1)],
		is_king = false
	}
	tokens["11"] = {
		scene = preload("res://scenes/tokens/11.tscn"),
		pattern = [
			Vector2(2, -2),
			Vector2(-2, -1),
			Vector2(-1, 0),
			Vector2(1, 1)],
		is_king = false
	}
	tokens["12"] = {
		scene = preload("res://scenes/tokens/12.tscn"),
		pattern = [
			Vector2(0, -1),
			Vector2(0, 1),
			Vector2(-1, 2),
			Vector2(1, 2)],
		is_king = false
	}
	tokens["13"] = {
		scene = preload("res://scenes/tokens/13.tscn"),
		pattern = [
			Vector2(0, -1),
			Vector2(-2, 0),
			Vector2(2, 0),
			Vector2(0, 1),
			Vector2(0, 2)],
		is_king = false
	}
	tokens["14"] = {
		scene = preload("res://scenes/tokens/14.tscn"),
		pattern = [
			Vector2(0, -1),
			Vector2(-2, 1),
			Vector2(2, 1),
			Vector2(0, 2)],
		is_king = false
	}
	tokens["15"] = {
		scene = preload("res://scenes/tokens/15.tscn"),
		pattern = [
			Vector2(-1, -1),
			Vector2(1, -1),
			Vector2(-2, 1),
			Vector2(2, 1)],
		is_king = false
	}
	tokens["16"] = {
		scene = preload("res://scenes/tokens/16.tscn"),
		pattern = [
			Vector2(-1, -1),
			Vector2(2, 0),
			Vector2(0, 1),
			Vector2(-1, 2)],
		is_king = false
	}
	tokens["17"] = {
		scene = preload("res://scenes/tokens/17.tscn"),
		pattern = [
			Vector2(1, -1),
			Vector2(-2, 0),
			Vector2(0, 1),
			Vector2(1, 2)],
		is_king = false
	}
	tokens["18"] = {
		scene = preload("res://scenes/tokens/18.tscn"),
		pattern = [
			Vector2(-1, -1),
			Vector2(-2, 0),
			Vector2(1, 0),
			Vector2(1, 1)],
		is_king = false
	}
	tokens["19"] = {
		scene = preload("res://scenes/tokens/19.tscn"),
		pattern = [
			Vector2(1, 1),
			Vector2(-1, 0),
			Vector2(2, 0),
			Vector2(-1, 1)],
		is_king = false
	}
	tokens["20"] = {
		scene = preload("res://scenes/tokens/20.tscn"),
		pattern = [
			Vector2(-1, -1),
			Vector2(-1, 1),
			Vector2(-1, 0),
			Vector2(1, 1)],
		is_king = false
	}
	tokens["21"] = {
		scene = preload("res://scenes/tokens/21.tscn"),
		pattern = [
			Vector2(-1, -1),
			Vector2(1, -1),
			Vector2(1, 0),
			Vector2(-1, 1)],
		is_king = false
	}
	tokens["22"] = {
		scene = preload("res://scenes/tokens/22.tscn"),
		pattern = [
			Vector2(-2, -1),
			Vector2(1, -1),
			Vector2(-1, 0),
			Vector2(1, 1)],
		is_king = false
	}
	tokens["23"] = {
		scene = preload("res://scenes/tokens/23.tscn"),
		pattern = [
			Vector2(-1, -1),
			Vector2(2, -1),
			Vector2(1, 0),
			Vector2(-1, 1)],
		is_king = false
	}
