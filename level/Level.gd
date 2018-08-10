extends Node2D

onready var nav = get_node("Nav")
onready var map = nav.get_node("Map")
onready var characters = get_node("Characters").get_children()

var active_character = null setget set_active_character

func _ready():
	set_process_input(true)
	for character in characters:
		character.map = map
		print(character.name, ": ", character.get_position())


func _input(event):
	if Input.is_action_just_pressed("click_left"):
		var tile_position = map.get_tile_at_mouse_position() + Vector2(32, 32)
		print("Destination: ", tile_position)
		for character in characters:
			if character.get_position() == tile_position:
				print(character.name, ": ", character.get_position())
				set_active_character(character)
				return
		
		if active_character != null:
			active_character.goal = tile_position
			active_character.nav = nav
	
	if Input.is_action_just_pressed("click_right") and active_character != null:
		set_active_character(null)


func set_active_character(new_character):
	if active_character != null:
		active_character.reduce_sprite()
		
	active_character = new_character
	print("character changed!: ", active_character)
	
	if active_character != null:
		active_character.enlarge_sprite()
	
	