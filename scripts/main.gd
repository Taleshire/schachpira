extends Control

# O V E R R I D E

func _ready():
	$Menu/Buttons/NewGame.connect("pressed", self, "_on_new_game_pressed")
	$Menu/Buttons/Quit.connect("pressed", self, "_on_quit_pressed")

# O N   S I G N A L

func _on_new_game_pressed():
	var map = "standard_2"
	var tokens = [
		[1, "sylvan"],
		[1, "bear"],
		[1, "wolf"],
		[1, "raven"],
		[1, "monkey"],
		[2, "god"],
		[2, "bear"],
		[2, "rhino"],
		[2, "rooster"],
		[2, "raven"],
	]
	global.new_game(map, tokens)

func _on_quit_pressed():
	get_tree().quit()
