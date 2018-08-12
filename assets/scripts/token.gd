extends Sprite

export(int) var ACTIONS_MAX : int = 8
export(int) var SIDE : int = 1

var actions

# V I R T U A L   F U N C T I O N S
func _ready():
	actions = ACTIONS_MAX

# P U B L I C   F U N C T I O N S

func reduce():
	scale = Vector2(0.8, 0.8)

func enlarge():
	scale = Vector2(1, 1)