extends VBoxContainer

func _on_exit_pressed():
	get_tree().quit()

func _on_2_player_match_pressed():
	var map = "standard_2"
	var tokens = [
		[1, "gold"],
		[1, "gold"],
		[2, "silver"],
		[2, "gold"],
		[2, "silver"],
		[2, "silver"],
		[2, "silver"],
	]
	global.new_match(map, tokens)


func _on_4_player_match_pressed():
	var map = "standard_4"
	var tokens = [
		[1, "gold"],
		[1, "silver"],
		[1, "gold"],
		[1, "gold"],
		[2, "silver"],
		[2, "gold"],
		[2, "silver"],
		[2, "gold"],
		[3, "silver"],
		[3, "gold"],
		[3, "silver"],
		[3, "silver"],
		[4, "silver"],
		[4, "silver"],
		[4, "silver"],
		[4, "silver"],
	]
	global.new_match(map, tokens)
