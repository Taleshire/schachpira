extends Node2D

const grid_size = 64

onready var nav = get_node("Nav")
onready var map = nav.get_node("Map")
onready var characters = get_node("Characters").get_children()

var active_character = null setget set_active_character

func _ready():
	set_process_input(true)
	for character in characters:
		character.map = map
	pass

func _input(event):
	if Input.is_action_just_pressed("click_left"):
		var mouse_position = get_global_mouse_position()
		var tile_position = get_tile_position(mouse_position)
		
		for character in characters:
			print(character.name, ": ", character.get_position())
			print("Destination: ", tile_position)
			if character.get_position() == tile_position:
				set_active_character(character)
				return
		
		if active_character != null:
			active_character.goal = tile_position
			active_character.nav = nav
	
	if Input.is_action_just_pressed("click_right") and active_character != null:
		set_active_character(null)
	pass
	
func get_tile_position(mouse_position):
	return map.world_to_map(mouse_position) * Vector2(grid_size, grid_size) + Vector2(grid_size / 2, grid_size / 2)
	pass

func set_active_character(new_character):
	if active_character != null:
		active_character.reduce_sprite()
		
	active_character = new_character
	print("character changed!: ", active_character)
	
	if active_character != null:
		active_character.enlarge_sprite()
	pass
	
	