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
	tokens["demon"] = {
		scene = preload("res://scenes/tokens/Demon.tscn"),
		pattern = [
			Vector2(-2, -2),
			Vector2(2, -2),
			Vector2(-1, 0),
			Vector2(1, 0),
			Vector2(-2, 2),
			Vector2(2, 2)],
		is_king = true
	}
	tokens["god"] = {
		scene = preload("res://scenes/tokens/God.tscn"),
		pattern = [
			Vector2(0, -2),
			Vector2(-1, -1),
			Vector2(-2, 0),
			Vector2(2, 0),
			Vector2(1, 1),
			Vector2(0, 2)],
		is_king = true
	}
	tokens["hound"] = {
		scene = preload("res://scenes/tokens/Hound.tscn"),
		pattern = [
			Vector2(-2, -2),
			Vector2(2, -2),
			Vector2(1, -1),
			Vector2(-1, 1),
			Vector2(-2, 2),
			Vector2(2, 2)],
		is_king = true
	}
	tokens["shadow"] = {
		scene = preload("res://scenes/tokens/Shadow.tscn"),
		pattern = [
			Vector2(0, -2),
			Vector2(1, -1),
			Vector2(-2, 0),
			Vector2(2, 0),
			Vector2(-1, 1),
			Vector2(0, 2)],
		is_king = true
	}
	tokens["sylvan"] = {
		scene = preload("res://scenes/tokens/Sylvan.tscn"),
		pattern = [
			Vector2(-2, -2),
			Vector2(2, -2),
			Vector2(-1, -1),
			Vector2(1, 1),
			Vector2(-2, 2),
			Vector2(2, 2)],
		is_king = true
	}
	tokens["titan"] = {
		scene = preload("res://scenes/tokens/Titan.tscn"),
		pattern = [
			Vector2(0, -2),
			Vector2(0, -1),
			Vector2(-2, 0),
			Vector2(2, 0),
			Vector2(0, 1),
			Vector2(0, 2)],
		is_king = true
	}
	tokens["bear"] = {
		scene = preload("res://scenes/tokens/Bear.tscn"),
		pattern = [
			Vector2(0, -2),
			Vector2(-2, -1),
			Vector2(1, 0),
			Vector2(1, 1)],
		is_king = false
	}
	tokens["cobra"] = {
		scene = preload("res://scenes/tokens/Cobra.tscn"),
		pattern = [
			Vector2(-1, -2),
			Vector2(1, -2),
			Vector2(0, -1),
			Vector2(0, 1)],
		is_king = false
	}
	tokens["fox"] = {
		scene = preload("res://scenes/tokens/Fox.tscn"),
		pattern = [
			Vector2(-2, -2),
			Vector2(2, -1),
			Vector2(1, 0),
			Vector2(-1, 1)],
		is_king = false
	}
	tokens["lynx"] = {
		scene = preload("res://scenes/tokens/Lynx.tscn"),
		pattern = [
			Vector2(2, -2),
			Vector2(-2, -1),
			Vector2(-1, 0),
			Vector2(1, 1)],
		is_king = false
	}
	tokens["rhino"] = {
		scene = preload("res://scenes/tokens/Rhino.tscn"),
		pattern = [
			Vector2(-1, -2),
			Vector2(1, -2),
			Vector2(-1, 1),
			Vector2(1, 1)],
		is_king = false
	}
	tokens["wolf"] = {
		scene = preload("res://scenes/tokens/Wolf.tscn"),
		pattern = [
			Vector2(0, -2),
			Vector2(2, -1),
			Vector2(-1, 0),
			Vector2(-1, 1)],
		is_king = false
	}
	tokens["dragonfly"] = {
		scene = preload("res://scenes/tokens/Dragonfly.tscn"),
		pattern = [
			Vector2(0, -1),
			Vector2(-2, 0),
			Vector2(2, 0),
			Vector2(0, 1),
			Vector2(0, 2)],
		is_king = false
	}
	tokens["goose"] = {
		scene = preload("res://scenes/tokens/Goose.tscn"),
		pattern = [
			Vector2(0, -1),
			Vector2(-2, 1),
			Vector2(2, 1),
			Vector2(0, 2)],
		is_king = false
	}
	tokens["monkey"] = {
		scene = preload("res://scenes/tokens/Monkey.tscn"),
		pattern = [
			Vector2(-1, -1),
			Vector2(1, -1),
			Vector2(-2, 1),
			Vector2(2, 1)],
		is_king = false
	}
	tokens["rabbit"] = {
		scene = preload("res://scenes/tokens/Rabbit.tscn"),
		pattern = [
			Vector2(-1, -1),
			Vector2(2, 0),
			Vector2(0, 1),
			Vector2(-1, 2)],
		is_king = false
	}
	tokens["rat"] = {
		scene = preload("res://scenes/tokens/Rat.tscn"),
		pattern = [
			Vector2(1, -1),
			Vector2(-2, 0),
			Vector2(0, 1),
			Vector2(1, 2)],
		is_king = false
	}
	tokens["rooster"] = {
		scene = preload("res://scenes/tokens/Rooster.tscn"),
		pattern = [
			Vector2(0, -1),
			Vector2(0, 1),
			Vector2(-1, 2),
			Vector2(1, 2)],
		is_king = false
	}
	tokens["boar"] = {
		scene = preload("res://scenes/tokens/Boar.tscn"),
		pattern = [
			Vector2(-1, -1),
			Vector2(-2, 0),
			Vector2(1, 0),
			Vector2(1, 1)],
		is_king = false
	}
	tokens["crow"] = {
		scene = preload("res://scenes/tokens/Crow.tscn"),
		pattern = [
			Vector2(-1, -1),
			Vector2(2, -1),
			Vector2(1, 0),
			Vector2(-1, 1)],
		is_king = false
	}
	tokens["deer"] = {
		scene = preload("res://scenes/tokens/Deer.tscn"),
		pattern = [
			Vector2(1, -1),
			Vector2(-1, 0),
			Vector2(2, 0),
			Vector2(-1, 1)],
		is_king = false
	}
	tokens["procupine"] = {
		scene = preload("res://scenes/tokens/Porcupine.tscn"),
		pattern = [
			Vector2(-1, -1),
			Vector2(1, -1),
			Vector2(1, 0),
			Vector2(-1, 1)],
		is_king = false
	}
	tokens["raven"] = {
		scene = preload("res://scenes/tokens/Raven.tscn"),
		pattern = [
			Vector2(-2, -1),
			Vector2(1, -1),
			Vector2(-1, 0),
			Vector2(1, 1)],
		is_king = false
	}
	tokens["turtle"] = {
		scene = preload("res://scenes/tokens/Turtle.tscn"),
		pattern = [
			Vector2(-1, -1),
			Vector2(1, -1),
			Vector2(-1, 0),
			Vector2(1, 1)],
		is_king = false
	}
