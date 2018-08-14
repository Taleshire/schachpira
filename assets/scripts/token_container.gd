extends Node2D

# P U B L I C   F U N C T I O N S

func get_tokens(_side : int = 0) -> Array:
	var tokens = get_children()
	if _side == 0:
		return tokens
	var side_tokens = []
	for token in tokens:
		if token.side == _side:
			side_tokens.append(token)
	return side_tokens