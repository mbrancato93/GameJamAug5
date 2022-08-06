extends KinematicBody2D
class_name member


var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _pre_physics_process():
	pass
	
func _post_physics_process():
	pass
	
func _physics_process(delta):
	self._pre_physics_process()
	
	# apply gravity
	self.velocity.y += Globals.scene.gravity
	
#	var collision = move_and_collide(velocity * delta)
#	if collision:
#		velocity = velocity.slide(collision.normal)

	# using move_and_slide
	velocity = move_and_slide(velocity, Vector2.UP)
	self._post_physics_process()
