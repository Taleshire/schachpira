extends Camera2D

const SPEED = 1000
const BORDER = 64

func _process(delta):
	var width = get_viewport_rect().size.x / 2 - BORDER
	var height = get_viewport_rect().size.y / 2 - BORDER
	var mouse_position = get_local_mouse_position()
	
	if mouse_position.x > width:
		var factor = abs(mouse_position.x - width) / BORDER 
		position.x += SPEED * delta * factor
	if mouse_position.x < -width:
		var factor = abs(mouse_position.x + width) / BORDER 
		position.x -= SPEED * delta * factor
	if mouse_position.y > height:
		var factor = abs(mouse_position.y - height) / BORDER 
		position.y += SPEED * delta * factor
	if mouse_position.y < -height:
		var factor = abs(mouse_position.y + height) / BORDER 
		position.y -= SPEED * delta * factor