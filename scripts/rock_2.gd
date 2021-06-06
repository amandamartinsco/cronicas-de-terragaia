extends KinematicBody2D

var rot_vel = PI*2

var vel = 200
var target

var target_slow = false
var target_fast = false

var dir 

func _physics_process(delta: float) -> void:
	if target:
		dir = global_position.direction_to(target.global_position) * -20
	dir = dir.normalized()
	dir = move_and_collide(dir)
	
func _on_rock_area_entered(area: Area2D) -> void:
	if area.has_method("hit"):
		area.hit(15, self)
	#se ele estrar na área de outro objeto destructable, ele se destrói e dá dano para aqle objeto
		queue_free()
