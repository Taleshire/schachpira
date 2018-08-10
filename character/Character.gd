extends KinematicBody2D

const grid_size : int = 64
onready var sprite : Sprite = get_node("Sprite")

export(int) var health : int = 100
export(int) var moves : int = 4
export(int) var initiative : int = 100
export(int) var strenth : int = 10

var speed : int = 250

var nav : Navigation2D = null setget set_nav
var map : TileMap = null
var path : PoolVector2Array
var goal : Vector2


func _ready():
	set_process(true)
	pass
	
func set_nav(new_nav):
	nav = new_nav
	update_path()
	pass
		
func update_path():
	path = nav.get_simple_path(get_position(), goal, false)
	pass

func _process(delta):
	if path.size() > 0:
		var distance = get_position().distance_to(path[0])
		if distance > 2:
			set_position(get_position().linear_interpolate(path[0], (speed * delta)/distance))
		else:
			path.remove(0)
			if path.size() == 0:
				set_position(get_tile_position())
	pass

func get_tile_position() -> Vector2: 
	return map.world_to_map(position) * Vector2(grid_size, grid_size) + Vector2(grid_size / 2, grid_size / 2)
	pass

func reduce_sprite():
	sprite.scale.x = 0.8
	sprite.scale.y = 0.8
	pass

func enlarge_sprite():
	sprite.scale.x = 1
	sprite.scale.y = 1
	pass