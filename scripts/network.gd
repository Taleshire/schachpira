extends Node

const DEFAULT_PORT = 8910

# O V E R R I D E

func _ready():
	set_pause_mode(PAUSE_MODE_PROCESS)
	get_tree().connect("network_peer_connected",self,"_player_connected")
	get_tree().connect('connected_to_server', self, '_connected_to_server')
	get_tree().connect("network_peer_disconnected",self,"_player_disconnected")
	get_tree().connect("server_disconnected",self,"_server_disconnected")

# P U B L I C

func create_server():
	var host = NetworkedMultiplayerENet.new()
	var err = host.create_server(DEFAULT_PORT, 1)
	if (err!=OK):
		return false
	get_tree().set_network_peer(host)
	return true


func create_client(_ip):
	if not _ip.is_valid_ip_address():
		return false
	var host = NetworkedMultiplayerENet.new()
	host.create_client(_ip, DEFAULT_PORT)
	get_tree().set_network_peer(host)
	return true

# O N   S I G N A L

func _player_connected(id):
	print(id, " connected")
	var map = "standard_2"
	var tokens = [
		[1, "sylvan"],
		[1, "bear"],
		[1, "wolf"],
		[1, "raven"],
		[1, "monkey"],
		[2, "god"],
		[2, "bear"],
		[2, "rhino"],
		[2, "rooster"],
		[2, "raven"],
	]
	global.new_game(map, tokens)
	get_tree().change_scene("res://scenes/Game.tscn")

func _connected_to_server():
	print("connection stable")

func _player_disconnected(id):
	get_tree().set_network_peer(null)
	print(id, " disconnected")
	get_tree().change_scene("res://scenes/Main.tscn")

func _server_disconnected():
	get_tree().set_network_peer(null)
	print("server closed")
	get_tree().change_scene("res://scenes/Main.tscn")