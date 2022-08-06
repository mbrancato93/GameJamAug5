extends member

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.velocity = Globals.player.speed
	pass # Replace with function body.

# overload _pre_physics_process
func _pre_physics_process():
	self.get_input()

func get_input():
	if Input.is_action_pressed( Globals.player.controls.jump ):
		if not self.is_on_floor():
			self.velocity.y += Globals.player.jump_inc
	if Input.is_action_pressed( Globals.player.controls.slow_time ):
		get_parent().send_message( "slow_time" )
	if Input.is_action_pressed( Globals.player.controls.reverse_time ):
		get_parent().send_message( "reverse_time" )

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
