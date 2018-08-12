extends VBoxContainer

func _on_new_match_pressed():
	global.new_match("standard", _generate_tokens())

func _on_exit_pressed():
	get_tree().quit()

func _generate_tokens() -> Array:
	var tokens : Array
	for i in range(8):
		tokens.append("standard")
	return tokens