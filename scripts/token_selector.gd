extends Node2D

export(int) var from = 0
export(int) var to = 23

var current_token = 0

var token_keys = []
var token_values = []

onready var token = $Token
onready var label = $Label

# O V E R R I D E

func _ready():
	current_token = from
	$Left.connect("pressed", self, "_on_left_pressed")
	$Right.connect("pressed", self, "_on_right_pressed")
	token_keys = global.tokens.keys()
	token_values = global.tokens.values()
	_update_token()

# P U B L I C

func get_key():
	return token_keys[current_token]

# O N   S I G N A L

func _on_left_pressed():
	current_token -= 1
	if current_token < from:
		current_token = to
	_update_token()

func _on_right_pressed():
	current_token += 1
	if current_token > to:
		current_token = from
	_update_token()

func _update_token():
	label.text = token_keys[current_token]
	token.texture = token_values[current_token].scene.instance().texture