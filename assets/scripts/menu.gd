extends VBoxContainer

func _on_new_match_pressed():
	# CHOOS MAP
	var map = "standard"
	
	var tokens = [
		[1, "gold"],
		[1, "gold"],
		[2, "silver"],
		[2, "gold"],
		[2, "silver"],
		[2, "silver"],
		[2, "silver"],
	]
	
	# LOAD MATCH
	global.new_match(map, tokens)

func _on_exit_pressed():
	get_tree().quit()