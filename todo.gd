# B U G S
#	[x] fix tile blocking when selecting another actor while the first one is still moving
#	[x] fix the fucking difference between local and global tile positions!
#	[x] fix drawn paths


# I M P R O V E M E N T
#	[x] change movement of tokens for precise walk
#	[x] smooth camera movement
#	[x] scroll camera with mouse on edges
#	[x] optimize find path | draw path methods to be faster
#	[x] press "n" to find tokens with actions left
#	[x] move _get_tokens_from_side to token container
#	[x] use get_tree().pause for pause menu

# G E N E R A L
#	USER INTERFACE
#	[x] hightlight selected tile
#	[x] draw black board border
#	[x] small tiltle screen
#	[x] write move_handler
#	[x] movable camera!
#	[x] Second Map with 4 Players
#	INGAME MENU
#		[x] freeze background input
#		[x] "Resume" should resume to game
#		[x] "Quit Match" should return to title screen
#	TILE SCREEN
#		[x] 2 Player Match
#		[x] 4 Player Match
#		[] start flash mode match
#		[] hero collection
#		[] build your team
#		[x] exit game


# N E T W O R K I N G
#	[] join lobby
#	[] create multiplayer match
#	[] play multiplayer match


# M O V E M E N T   S Y S T E M
#	[x] move just one token in a turn!
#	[x] tokens can move
#	[x] tokens can only move as much as they have moves
#	[x] recognize blocked tiles
#	[x] draw / highlight reachable tiles
#	[x] draw preview for path
#	[x] make path editable
#		[x] one click sets a checkpoint
#		[x] another click on the same tile moves the actor
#		[x] another click on another tile sets another checkpoint


# T U R N   S Y S T E M
#	[x] add a "turn end" button
#	[x] recognize which side's turn it is 
#	[x] reset actions
#	[] earn honor


# C O M B A T   S Y S T E M
#	TOKENS
#		[x] recognize allies and foes
#		[] switch between move and attack mode with "space"
#		[] tokens can attack foes
#		[] draw / highlight attackable tiles
#		[] give tokens a type
#		[] higher defense at favourable positions
#		[] lower defense at non contrary positions


#	F L A S H   M O D E
#	[]


# G R A P H I C S
#	TILES
#		[x] BORDER
#		[x] LIGHT BROWN (earth)
#		[x] BLUE (water)
#		[x] RED (fire)
#		[X] ALMOST WHITE (air)
#		[x] GOLD (spirit)
#		[x] DARK BLUE (decay)
#		[x] GREEN (life)
#		[x] DARK BROWN (death)
#		[x] SILVER (order)
#		[x] GREEN'ISH VIOLET (chaos)
#	STONES
#		[] LIGHT BROWN (earth)
#		[] BLUE (water)
#		[] RED (fire)
#		[] LIGHT BLUE (air)
#		[X] GOLD (spirit)
#		[] BLUE'ISH BLACK (decay)
#		[] GREEN (life)
#		[] GREEN'ISH BROWN (death)
#		[X] SILVER (order)
#		[] PINK (chaos)
#
