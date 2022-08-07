extends Node2D

signal environmental_hazard

var playerPosition: Vector2 = Vector2.ZERO

onready var rng = RandomNumberGenerator.new()

func clairvoyance():
	# generate the stage at a predefinded future point
	
	# get the current position of the player
	var playerPosition: Vector2 = $Player.position
	
	var genPosition: Vector2 = $TileMap.world_to_map( playerPosition ) + Vector2( Globals.scene.tileMap_foresight, 0 )
	genPosition.y = Globals.scene.max_platform_height
	
	var predecessor: int = -1
	var selectedCell: int = -1
	var r: float = 0.0
	# loop through from the floor to the max platform position and randomly select
	for y_offset in range( Globals.scene.max_platform_height, 0, -1 ):
		selectedCell = -1
		
		genPosition.y = y_offset
		
		# check the predecensor
		predecessor = $TileMap.get_cell( genPosition.x-1, genPosition.y )
		
		if y_offset == Globals.scene.max_platform_height:
			r = rng.randf_range( 0.0, 1.0 )
			if r < Globals.scene.preferences[ Globals.scene.tilemap.street ].floor_spikes:
				selectedCell = Globals.scene.tilemap.floor_spikes
			else:
				selectedCell = Globals.scene.tilemap.street
		elif predecessor == -1 && y_offset < Globals.scene.max_platform_height-1:
			if rng.randf_range( 0.0, 1.0 ) < Globals.scene.preferences[ Globals.scene.tilemap.platform ].empty:
				selectedCell = Globals.scene.tilemap.platform
		else:
			r = rng.randf_range( 0.0, 1.0 )
			if r < Globals.scene.preferences[ predecessor ].floor_spikes:
				selectedCell = Globals.scene.tilemap.floor_spikes
			elif r < Globals.scene.preferences[ predecessor ].wall_spikes:
				selectedCell = Globals.scene.tilemaps.wall_spikes
			elif r < Globals.scene.preferences[ predecessor ].street:
				selectedCell = Globals.scenes.tilemap.street
			elif r < Globals.scene.preferences[ predecessor ].platform:
				selectedCell = Globals.scene.tilemap.platform
			
		$TileMap.set_cell( genPosition.x, genPosition.y, selectedCell )
		if selectedCell != -1 && y_offset < Globals.scene.max_platform_height:
			break

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	var c: int = $TileMap.get_cell( 0, 2 )
	print( $TileMap.get_cell( 0,2 ) )
	$TileMap.set_cell( 1, 1, c )
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $TileMap.world_to_map( $Player.position ).x != playerPosition.x:
		clairvoyance()
		playerPosition = $TileMap.world_to_map( $Player.position )
		
		$CanvasLayer/Label.text = "Player: ({x},{y})".format({"x": playerPosition.x, "y": playerPosition.y})
		
		if $TileMap.get_cell( playerPosition.x, playerPosition.y ) == Globals.scene.tilemap.floor_spikes || $TileMap.get_cell( playerPosition.x, playerPosition.y ) == Globals.scene.tilemap.wall_spikes:
			emit_signal( "environmental_hazard" )
