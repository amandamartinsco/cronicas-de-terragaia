extends Node2D

var first_time = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_Area2D_area_entered(area: Area2D) -> void:
	if first_time == 0:
		$AnimationPlayer.play("walk")
		first_time = 1
