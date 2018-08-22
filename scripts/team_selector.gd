extends Node2D

var side = 1

func _ready():
	pass

# PUBLIC

func get_team():
	var team = []
	for s in $Selectors.get_children():
		team.append(s.get_key())
	return team
