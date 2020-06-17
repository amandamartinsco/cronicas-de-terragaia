extends Area2D

signal damage(damage, node)

func hit(damage, node):
	#é pra bater com o hit do bullet
	emit_signal("damage", damage, node)

