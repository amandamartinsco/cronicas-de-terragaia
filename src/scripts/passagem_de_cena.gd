extends Area2D

export(String, FILE, "*.tscn") var cenas

var cena_atual = 1

func _on_Area2D_body_entered(body):
	if body.name == "player":
		get_tree().change_scene("res://scenes/part_2.tscn")
		cena_atual += 1

func _on_area_area_entered(area: Area2D) -> void:
	get_tree().call_group("camera", "shake", 2, 0.49)
	$AnimationPlayer.play("out_of_ground")
	yield($AnimationPlayer, "animation_finished")
	$area.queue_free()
