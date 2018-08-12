extends VBoxContainer

func _on_new_match_pressed():
	# CHOOS MAP
	var map = "standard"
	
	# CHOOSE TOKENS
	var tokens = [
		
		# TEAM 1
		"gold",
		"gold",
		"gold",
		"gold",
		
		# TEAM 2
		"silver",
		"silver",
		"silver",
		"silver",
	]
	
	# LOAD MATCH
	global.new_match(map, tokens)

func _on_exit_pressed():
	get_tree().quit()