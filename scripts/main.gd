extends Control

# O V E R R I D E

# TEST COMMENT
func _ready():
	$Menu/Buttons/Singleplayer.connect("pressed", self, "_on_singleplayer_pressed")
	$Menu/Buttons/Multiplayer.connect("pressed", self, "_on_multiplayer_pressed")
	$Menu/Buttons/Quit.connect("pressed", self, "_on_quit_pressed")

# O N   S I G N A L

func _on_multiplayer_pressed():
	get_tree().change_scene("res://scenes/Lobby.tscn")
	
func _on_singleplayer_pressed():
	var map = "standard_2"
	var tokens = [
		[1, "00"],
		[1, "08"],
		[1, "10"],
		[1, "12"],
		[1, "14"],
		[2, "01"],
		[2, "09"],
		[2, "11"],
		[2, "13"],
		[2, "15"],
	]
	global.new_game(map, tokens)
	get_tree().change_scene("res://scenes/Game.tscn")

func _on_quit_pressed():
	get_tree().quit()
