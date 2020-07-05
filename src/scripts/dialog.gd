extends Control

var dialog = ['Hora de caçar alguns lobos!', 'Tenho que usar meu escudo para me defender e aproveitar o tempo de recuo para atacar', 'Minha magia está no máximo, só preciso apertar Tab e poderei acabar com esses lobos bem mais rápido', 'Tem batatas ali, acho que posso levar algumas para casa hoje também', 'Não!!!! A vila toda está pegando fogo', 'Quem era aquela pessoa? Ela foi nessa direção...', 'O que é isso? Um pilar? O que devo fazer com isso? Vou dar uma olhada', 'Esqueletos gigantes? Nunca vi esses monstros por essas terras, algo de errado não está certo. Ainda bem que eles são cegos', 'Meu escudo não funciona nessas coisas, então tudo que me resta é esperar ele parar de atacar e assim agir', 'Mais uma dessas coisas estranhas, se quero descobrir a verdade sobre terei que ir em direção ao desconhecido', 'Quem é voce? Diga logo o porque fez isso!', 'Eu? Eu sou você!', ' Um feitiço da natureza que deu errado, trazemos a vida e entregamos a morte', 'Eu sou o caos, e sou o seu oposto e ao mesmo tempo sou parte de ti, meu destino é sempre reinar no final dos mundos', 'Não importa quantos universos nação ou morram, sempre nos encontramos no fim', 'Até mais heroi... até o proximo ato desse ritual doentio e sem fim...']

var page = 0
var max_page = 0

signal end(po)

func _process(delta: float) -> void:
	if get_parent().get_parent().get_filename() == "res://scenes/part_3.tscn":
		get_tree().get_nodes_in_group("boss")[0].connect("pode_falar", self, "_boss")
		
	else:
		pass
		
func _input(event):
	if Input.is_action_just_pressed("ui_enter"):
		if $TextureRect/RichTextLabel.visible_characters > $TextureRect/RichTextLabel.get_total_character_count():
			if page < max_page:
				page += 1
				$TextureRect/RichTextLabel.bbcode_text = dialog[page]
				$TextureRect/RichTextLabel.visible_characters = 0
			if page >= max_page:
				$TextureRect.visible = false
				if get_parent().get_parent().get_filename() == "res://scenes/part_3.tscn":
					emit_signal("end", true)
		else:
			$TextureRect/RichTextLabel.visible_characters = $TextureRect/RichTextLabel.get_total_character_count()
				
	if $TextureRect/RichTextLabel.visible_characters >= $TextureRect/RichTextLabel.get_total_character_count(): 
		$"TextureRect/next-indicator".visible = true	
		
	else:
		$"TextureRect/next-indicator".visible = false
func _on_Timer_timeout() -> void:
	$TextureRect/RichTextLabel.visible_characters += 1

func _on_0_area_entered(area: Area2D) -> void:
	talk(0,0)
	get_tree().get_nodes_in_group("dialog_areas")[0].queue_free()
	
func talk(begin, end):
	$TextureRect.visible = true
	page = begin
	max_page = end
	$TextureRect/RichTextLabel.bbcode_text = dialog[page]
	$TextureRect/RichTextLabel.visible_characters = 0
	set_process_input(true)	

func _on_1_area_entered(area: Area2D) -> void:
	talk(1,1)
	get_tree().get_nodes_in_group("dialog_areas")[0].queue_free()
	
func _on_2_area_entered(area: Area2D) -> void:
	talk(3,3)
	get_tree().get_nodes_in_group("dialog_areas")[0].queue_free()
	
func _on_3_area_entered(area: Area2D) -> void:
	talk(4,4)
	get_tree().get_nodes_in_group("dialog_areas")[0].queue_free()
	
func _on_4_area_entered(area: Area2D) -> void:
	talk(5,5)
	get_tree().get_nodes_in_group("dialog_areas")[0].queue_free()
	
func _on_5_area_entered(area: Area2D) -> void:
	talk(7,9)
	get_tree().get_nodes_in_group("dialog_areas")[0].queue_free()
	
#func _on_6_area_entered(area: Area2D) -> void:
#	talk(8,8)
#	get_tree().get_nodes_in_group("dialog_areas")[0].queue_free()
	
func _boss(po):
	if po == true:
		talk(10,15)
		talk(15,15)

func _on_7_area_entered(area: Area2D) -> void:
	talk(6,6)

func _on_8_area_entered(area: Area2D) -> void:
	talk(9,9)
