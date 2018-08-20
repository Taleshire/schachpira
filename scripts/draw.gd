extends Control

var game

var selection

func _process(delta):
	if game:
		draw_selection()

func _ready():
	selection = Sprite.new()
	selection.texture = textures.mark.gold
	selection.centered = false
	add_child(selection)

func draw_selection():
	selection.position = game.map.get_mouse_position()

func draw_move_marker(_cells):
	_remove_all_marker($MoveContainer)
	for cell in _cells:
		var cell_position = game.map.map_to_world_centered(cell)
		_add_marker($MoveContainer, textures.mark.silver, cell_position)

func clear_move_marker():
	_remove_all_marker($MoveContainer)

# P R I V A T E

func _add_marker(_container, _texture, _position, _scale = Vector2(0.9, 0.9), _centered = true ):
	var marker = Sprite.new()
	marker.texture = _texture
	marker.scale = _scale
	marker.centered = _centered
	marker.position = _position
	print("Draw Marker at: ", marker.position)
	_container.add_child(marker)

func _remove_all_marker(_container):
	var children = _container.get_children()
	for c in children:
		c.queue_free()