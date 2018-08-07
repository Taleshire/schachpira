extends KinematicBody2D

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _input(event):
	var pos = get_position()
	
	if Input.is_action_just_pressed("ui_down"):
		pos += Vector2(0, 64)
	elif Input.is_action_just_pressed("ui_up"):
		pos += Vector2(0, -64)
	elif Input.is_action_just_pressed("ui_left"):
		pos += Vector2(-64, 0)
	elif Input.is_action_just_pressed("ui_right"):
		pos += Vector2(64, 0)
		
	set_position(pos)
	pass
	
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
