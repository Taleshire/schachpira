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
	tokens["gold"] = { 
		scene = preload("res://assets/scenes/tokens/Gold.tscn")}
	tokens["silver"] = { 
		scene = preload("res://assets/scenes/tokens/Silver.tscn")}

func new_match(_map : String, _tokens : Array):
	map_id = _map
	token_ids = _tokens
	var err = get_tree().change_scene("res://assets/scenes/Match.tscn")
	print("NEW MATCH")