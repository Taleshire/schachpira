extends Sprite

signal position_changed
var current_position

func _ready():
	current_position = position

func _process(delta):	
	if position != current_position:
		current_position = position
		emit_signal("position_changed")