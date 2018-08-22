extends Control

const DEFAULT_PORT = 8910

# O V E R R I D E

func _ready():
	$CC/VBoxContainer/Buttons/Join.connect("pressed", self, "_on_join_pressed")
	$CC/VBoxContainer/Buttons/Host.connect("pressed", self, "_on_host_pressed")
	$CC/VBoxContainer/Back.connect("pressed", self, "_on_back_pressed")
	
# P U B L I C



# P R I V A T E

func _set_status(text,isok):
	if (isok):
		$CC/VBoxContainer/Status/OK.set_text(text)
		$CC/VBoxContainer/Status/FAIL.set_text("")
	else:
		$CC/VBoxContainer/Status/OK.set_text(text)
		$CC/VBoxContainer/Status/FAIL.set_text("")


# O N   S I G N A L

func _on_join_pressed():
	var ip = $CC/VBoxContainer/IP/Adress.get_text()
	network.create_client(ip)
	_set_status("Connecting..", true)

func _on_host_pressed():
	network.create_server()
	$CC/VBoxContainer/Buttons/Join.set_disabled(true)
	$CC/VBoxContainer/Buttons/Host.set_disabled(true)
	_set_status("Waiting for player..", true)

func _on_back_pressed():
	get_tree().change_scene("res://scenes/Main.tscn")