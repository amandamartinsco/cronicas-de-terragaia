extends KinematicBody2D

export var velocity = Vector2(0,0)

export var gravity = 500

const UP = Vector2(0, -1)

var direction 

func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x = 100 * direction

	move_and_slide(velocity, UP)
