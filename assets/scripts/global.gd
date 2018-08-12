extends Node

var maps : Dictionary
var tokens : Dictionary

var map_id : String
var token_ids : Array

func _ready():
	_fill_map_dictionary()
	_fill_token_dictionary()

func _fill_map_dictionary():
	maps["standard"] = {
		scene = preload("res://assets/scenes/maps/Map.tscn")}

func _fill_token_dictionary():
	tokens["standard"] = { 
		scene = preload("res://assets/scenes/tokens/Token.tscn")}

func new_match(_map_id, _token_ids):
	map_id = _map_id
	token_ids = _token_ids
	var err = get_tree().change_scene("res://assets/scenes/Match.tscn")
	print("NEW MATCH")