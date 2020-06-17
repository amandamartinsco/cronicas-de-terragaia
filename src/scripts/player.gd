extends KinematicBody2D

export var velocity = Vector2(0,100)

export var gravity = 500

const UP = Vector2(0, -1)

var direction 

signal life_scale(sc)

export var life = 300

onready var init_life = life

func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x = 100 * direction
	
	if direction >= 0:
		$HumanBase2.flip_h = false
		
	if direction <0:
		$HumanBase2.flip_h = true
	
	if direction != 0:
		$AnimationPlayer.play("walk")
		
	if direction == 0:
		$AnimationPlayer.play("sand_side")

	move_and_slide(velocity, UP)

func _on_damage_area_damage(damage, node) -> void:
	life -= damage
	
	emit_signal("life_scale", (float(self.life) / float(self.init_life)))

func _on_Area2D_area_entered(area):
	_on_damage_area_damage(50, $".")
