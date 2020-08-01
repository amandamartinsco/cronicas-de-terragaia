extends CanvasLayer

func _ready():
	get_tree().get_nodes_in_group("player")[0].connect("hasSword", self, "on_has_sword")
	# Ele irá verificar qual tecla o jogador está apertando para demonstrar na HUD
#	if Input.is_action_pressed("ui_attack"):
#		$attackButton.get_pressed_texture()
#	else:
#		$attackButton.get_normal_texture()
#	if Input.is_action_pressed("ui_jump"):
#		$jumpButton.set_pressed(true)
#	else:
#		$jumpButton.set_pressed(false)
#	if Input.is_action_pressed("ui_accept"):
#		$takeButton.set_pressed(true)
#	else:
#		$takeButton.set_pressed(false)
#	if Input.is_action_pressed("ui_magic"):
#		$magicButton.set_pressed(true)
#	else:
#		$magicButton.set_pressed(false)

func on_has_sword(t):
	#Ele irá checar se espada já está equipada para mostrar na HUD
		if t == true:
			$swordIcon.set_pressed(true)
		else:
			$swordIcon.set_pressed(false)
