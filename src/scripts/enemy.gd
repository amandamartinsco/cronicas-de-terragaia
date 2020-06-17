extends KinematicBody2D

export var velocity = Vector2(10,0)

export var gravity = 500

const UP = Vector2(0, -1)

var comeco = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	velocity.x = - velocity.x
	set_physics_process(false)

func _physics_process(delta: float) -> void:
	$RayCast2D.enabled = true
	velocity.y = gravity
	
	if is_on_wall():
		velocity.x = velocity.x * -1
		$"RayCast2D".cast_to.x *= -1
		
	if $"RayCast2D".is_colliding():
		if velocity.x < 0:
			velocity.x = -30
			$BaseArmoredDemo.flip_h = false
			
		if velocity.x >= 0:
			velocity.x = 30		
			$BaseArmoredDemo.flip_h = true
		$AnimationPlayer.play("run")
	else:
		if velocity.x < 0:
			velocity.x = -15
			$BaseArmoredDemo.flip_h = false
			
		if velocity.x >= 0:
			velocity.x = 15		
			$BaseArmoredDemo.flip_h = true
		$AnimationPlayer.play("walk")	
	
	
	move_and_slide(velocity, UP)
	
func _on_VisibilityNotifier2D_screen_entered() -> void:
	set_physics_process(true)

func _on_VisibilityNotifier2D_screen_exited() -> void:
	set_physics_process(false)
