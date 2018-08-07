extends KinematicBody2D

var player = load("res://character/Character.tscn")

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _input(event):
	if Input.is_action_just_pressed("click_left"):
		var pos = player.get_position()
		pos += Vector2(0, 64)
		player.set_position(pos)
	pass
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
