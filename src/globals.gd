extends Node2D

class_name globals

class member extends Node2D:
	pass
	
class player extends member:
	var face_moving: bool = true
	var speed: float = 10.0
	var jump_inc: float = 10.0
	class controls:
		var jump = "jjump"
		var slow_time = "slow_time"
		var reverse_time = "reverse_time"
	
class scene extends Node2D:
	pass
	
class time extends Node2D:
	pass
	
class scene_flow extends Node2D:
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
