extends Area2D

export(String, FILE, "*.tscn") var cenas

var cena_atual = 1

func _on_Area2D_body_entered(body):
	if body.name == "player":
		get_tree().change_scene("res://scenes/part_2.tscn")
		cena_atual += 1
