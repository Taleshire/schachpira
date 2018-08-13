extends Node2D

var click_left : bool

func _input(event):
	click_left = Input.is_action_just_pressed("click_left")
	
	if event is InputEventMouseButton and click_left:
		print("click / unclick")
