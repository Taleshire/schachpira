extends Control

func _ready():
	$Menu/Buttons/Resume.connect("pressed", self, "_on_resume_pressed")
	$Menu/Buttons/QuitGame.connect("pressed", self, "_on_quit_game_pressed")

func _input(event):
	if Input.is_action_just_pressed("esc"):
		get_tree().paused = !get_tree().paused
		visible = !visible

func _on_resume_pressed():
	visible = !visible
	get_tree().paused = !get_tree().paused

func _on_quit_game_pressed():
	visible = !visible
	get_tree().paused = !get_tree().paused
	get_tree().set_network_peer(null)
	get_tree().change_scene("res://scenes/Main.tscn")

