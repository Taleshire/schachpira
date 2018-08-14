extends Control

func _input(event):
	if Input.is_action_just_pressed("escape"):
		get_tree().paused = !get_tree().paused
		visible = !visible

func _on_resume_pressed():
	visible = !visible
	get_tree().paused = !get_tree().paused

func _on_quit_match_pressed():
	get_tree().paused = !get_tree().paused
	get_tree().change_scene("res://assets/scenes/Main.tscn")

