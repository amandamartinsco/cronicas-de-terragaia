extends Area2D

export(String, FILE, "*.tscn") var cenas

func _on_Area2D_body_entered(body):
	if body.name == "player":
		get_tree().change_scene("res://scenes/part_2.tscn")
