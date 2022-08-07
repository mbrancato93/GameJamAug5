extends member

var state_machine
var desired_x_vel: float = Globals.player.speed

func environmental_hazard():
	state_machine.travel( "hit" )

func damage_complete():
	desired_x_vel = Globals.player.speed

# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().connect( "environmental_hazard", self, "environmental_hazard" )
	
	state_machine = $AnimationTree.get("parameters/playback")
	self.velocity.x = Globals.player.speed
	pass # Replace with function body.

# overload _pre_physics_process
func _pre_physics_process():
	self.get_input()
	self.velocity.x = desired_x_vel

func get_input():
	if Input.is_action_pressed( Globals.player.controls.jump ):
		if self.is_on_floor():
			self.velocity.y = -Globals.player.jump_inc
			state_machine.travel( "jump" )
			$CPUParticles2D.anim_offset = 0.8
	if Input.is_action_pressed( Globals.player.controls.slow_time ):
		get_parent().send_message( "slow_time" )
	if Input.is_action_pressed( Globals.player.controls.reverse_time ):
		get_parent().send_message( "reverse_time" )
		
func _post_physics_process( collisions ):
	for c in collisions:
		if c.collider.name == "TileMap" and ( state_machine.get_current_node() != "run" or state_machine.get_current_node() != "hit" ):
			if state_machine.get_current_node() == "jump" or state_machine.get_current_node() == "hit":
				state_machine.travel( "run" )
			$CPUParticles2D.anim_offset = 0.11 
	
#	if self.is_on_floor():
##		state_machine.travel( "run" )
#		$CPUParticles2D.anim_offset = 0.11
#	else:
##		state_machine.travel( "jump" )
#		$CPUParticles2D.anim_offset = 0.8
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
