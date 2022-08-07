extends Node2D

class_name globals

class _character extends Node2D:
	pass
	
class _player extends _character:
	var face_moving: bool = true
	var speed: float = 100.0
	var jump_inc: float = 300.0
	var controls
	class _controls:
		var jump: String = "jump"
		var slow_time: String = "slow_time"
		var reverse_time: String = "reverse_time"
		
		func _init():
			pass
	
	func _init():
		controls = self._controls.new()

var player : _player = _player.new()
	
class _scene extends Node2D:
	var gravity: float = 5.0
	var tileMap_foresight: int = 10
	var max_platform_height: int = 8
	var tilemap
	var preferences
	
	class tm:
		var platform: int = 0
		var street: int = 2
		var floor_spikes: int = 1
		var wall_spikes: int = 3
		
		func _init():
			pass
		
	class _pref:
		var platform: float = 0.0
		var street: float = 0.0
		var floor_spikes: float = 0.0
		var wall_spikes: float = 0.0
		var empty: float = 0.0
		
	func _init():
		self.tilemap = self.tm.new()
		self.preferences = []
		for i in range( 4 ):
			self.preferences.append( self._pref.new() )
			
		self.preferences[ self.tilemap.platform ].platform = 0.75
		self.preferences[ self.tilemap.platform ].street = 0.0
		self.preferences[ self.tilemap.platform ].floor_spikes = 0.5
		self.preferences[ self.tilemap.platform ].wall_spikes = 0.0
		self.preferences[ self.tilemap.platform ].empty = 0.25
		
		self.preferences[ self.tilemap.street ].platform = 0.0
		self.preferences[ self.tilemap.street ].street = 1.0
		self.preferences[ self.tilemap.street ].floor_spikes = 0.0
		self.preferences[ self.tilemap.street ].wall_spikes = 0.0
		
		self.preferences[ self.tilemap.floor_spikes ].platform = 0.7
		self.preferences[ self.tilemap.floor_spikes ].street = 0.0
		self.preferences[ self.tilemap.floor_spikes ].floor_spikes = 0.3
		self.preferences[ self.tilemap.floor_spikes ].wall_spikes = 0.0
		
		self.preferences[ self.tilemap.wall_spikes ].platform = 0.8
		self.preferences[ self.tilemap.wall_spikes ].street = 0.0
		self.preferences[ self.tilemap.wall_spikes ].floor_spikes = 0.1
		self.preferences[ self.tilemap.wall_spikes ].wall_spikes = 0.0
		
var scene : _scene = _scene.new()
	
class _time extends Node2D:
	pass
	
class _scene_flow extends Node2D:
	var scenes = []
	var currentSceneIndex: int = 0
	
	func _init():
		# define intial scene here
		self.scenes.append( "res://scenes/title.tscn" )
		# self.scenes.append( "res://scenes/scene1.tscn")
		
	func change_scenes( scn ):
		if scn == "NULL":
			return false
		get_tree().change_scene( scn )
		
	func getCurrentScene():
		return [ self.scenes[ self.currentSceneIndex ], self.currentSceneIndex ]
		
	func nextScene():
		if self.numScenes() == ( self.currentSceneIndex ):
			return [ -1, "NULL" ]
		self.currentSceneIndex += 1
		return self.getCurrentScene()
		
	func previousScene():
		if self.numScenes() == 0:
			return [ -1, "NULL" ]
		self.currentSceneIndex -= 1
		return self.getCurrentScene()
		
	func getTailScene():
		if self.numScenes() == 0:
			return [ -1, "NULL" ]
		self.currentSceneIndex = self.numScenes()
		return getCurrentScene()
	
	func numScenes():
		return len( self.scenes )
		
	func pushScene( scn: String ):
		var file2Check = File.new()
		if not file2Check.file_exists( scn ):
			return false
		self.scenes.append( scn )
		return true
		
	func popScene( scn ):
		if self.numScenes() == 0:
			return false
		var r = self.getCurrentScene()
		self.currentSceneIndex -= 1
		return r
