extends Control

# O V E R R I D E

func _ready():
	$Menu/Buttons/Singleplayer.connect("pressed", self, "_on_singleplayer_pressed")
	$Menu/Buttons/Multiplayer.connect("pressed", self, "_on_multiplayer_pressed")
	$Menu/Buttons/Quit.connect("pressed", self, "_on_quit_pressed")

# O N   S I G N A L

func _on_multiplayer_pressed():
	get_tree().change_scene("res://scenes/Lobby.tscn")
	
func _on_singleplayer_pressed():
	pass

func _on_quit_pressed():
	get_tree().quit()
