extends Camera2D

func _input(event):
	if Input.is_action_just_pressed("ui_right"):
		position += Vector2(64, 0)
	if Input.is_action_just_pressed("ui_left"):
		position += Vector2(-64, 0)
	if Input.is_action_just_pressed("ui_up"):
		position += Vector2(0, -64)
	if Input.is_action_just_pressed("ui_down"):
		position += Vector2(0, 64)
