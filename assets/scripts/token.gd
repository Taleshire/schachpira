extends Sprite

var team_blue = preload("res://assets/sprites/stones/team_blue.png")
var team_red = preload("res://assets/sprites/stones/team_red.png")
var team_green = preload("res://assets/sprites/stones/team_green.png")
var team_yellow = preload("res://assets/sprites/stones/team_yellow.png")

export(int) var ACTIONS_MAX : int = 8

var side : int = 1 setget _set_side
var actions

# V I R T U A L   F U N C T I O N S
func _ready():
	actions = ACTIONS_MAX

# P U B L I C   F U N C T I O N S

func has_actions_left() -> bool:
 	return actions > 0

func turn_end():
	actions = ACTIONS_MAX

func reduce():
	scale = Vector2(0.8, 0.8)

func enlarge():
	scale = Vector2(1, 1)

func _set_side(_side):
	side = _side
	if _side == 1:
		$TC.texture = team_red
	if _side == 2:
		$TC.texture = team_blue
	if _side == 3:
		$TC.texture = team_green
	if _side == 4:
		$TC.texture = team_yellow
	