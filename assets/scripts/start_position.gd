extends Position2D

export(int) var SIDE = 1

func place_stone(var _stone : Sprite) -> void:
	_stone.position = position
