extends Control

onready var label = $Menu/Buttons/Label

func _ready():
	$Menu/Buttons/QuitGame.connect("pressed", self, "_on_quit_game_pressed")

func show():
	get_tree().paused = !get_tree().paused
	visible = !visible

func _on_quit_game_pressed():
	get_tree().paused = !get_tree().paused
	get_tree().change_scene("res://scenes/Main.tscn")

