extends Control

onready var label = $Menu/Buttons/Label

func _ready():
	$Menu/Buttons/QuitGame.connect("pressed", self, "_on_quit_game_pressed")

func show():
	visible = !visible

func _on_quit_game_pressed():
	visible = !visible
	get_tree().set_network_peer(null)
	get_tree().change_scene("res://scenes/Main.tscn")


