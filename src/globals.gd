extends Node2D

class_name globals

class _character extends Node2D:
	pass
	
class _player extends _character:
	var face_moving: bool = true
	var speed: float = 10.0
	var jump_inc: float = 100.0
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
