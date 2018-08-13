extends Node2D

const BASE_LINE_WIDTH = 3.0
const DRAW_COLOR = Color('#fff')

var mark_gold = preload("res://assets/sprites/ui/mark_gold.png")
var mark_blue = preload("res://assets/sprites/ui/mark_blue.png")

var Marker = preload("res://assets/scenes/utils/Marker.tscn")

var match_
var marker_gold

# V I R T U A L   F U N C T I O N S

func _ready():
	marker_gold = Marker.instance()
	marker_gold.texture = mark_gold
	marker_gold.centered = false
	add_child(marker_gold)
	print("DRAW READY!")
	pass

# P U B L I C   F U N C T I O N S

func draw_selection() -> void:
	marker_gold.position = match_.map.world_to_world(get_global_mouse_position())

func draw_path(_path : Array, _range : int = 50) -> void:
	var counter : int = 1
	_remove_all_marker($PathContainer)
	if !_path.empty():
		for point in _path:
			var point_position = match_.map.map_to_world_centered(point)
			_add_marker($PathContainer, mark_blue, point_position, Vector2(0.7, 0.7))
			counter += 1
			if counter > _range:
				return


func draw_move_marker(_reachable_cells : Array) -> void:
	_remove_all_marker($MoveContainer)
	for cell in _reachable_cells:
		var cell_position = match_.map.map_to_world_centered(cell)
		_add_marker($MoveContainer, mark_blue, cell_position)

func draw_attack_marker(_reachable_cells : Array) -> void:
	pass

func draw_token_status() -> void:
	pass

func clear_path_marker() -> void:
	_remove_all_marker($PathContainer)

func clear_move_marker() -> void:
	_remove_all_marker($MoveContainer)
# P R I V A T E   F U N C T I O N S

func _add_marker(
		_container : Node, 
		_texture : Texture, 
		_position : Vector2, 
		_scale : Vector2 = Vector2(0.9, 0.9), 
		_centered : bool = true
		) -> void:
	var marker = Marker.instance()
	marker.texture = _texture
	marker.scale = _scale
	marker.centered = _centered
	marker.position = _position
	_container.add_child(marker)

func _remove_all_marker(_container):
	var children = _container.get_children()
	for c in children:
		c.queue_free()