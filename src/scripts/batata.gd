extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
#func _ready():
#	$Sprite.visible = false
#	get_tree().get_nodes_in_group("enemy")[0].connect("pode_dropar", self, "dropar")
#	get_tree().get_nodes_in_group("enemy")[1].connect("pode_dropar", self, "dropar")

func dropar(pd):
	print($".".position)
	$".".position = pd
	$Sprite.visible = true
	
	
