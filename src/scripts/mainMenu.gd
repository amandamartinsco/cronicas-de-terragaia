extends Control

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		$pressSpace.set_pressed(true)
		$themeSong.stop()
		get_tree().change_scene("res://scenes/enemy.tscn")
