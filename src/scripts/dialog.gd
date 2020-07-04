extends Control

var dialog = ['Hora de caçar alguns lobos!', 'Tenho que usar meu escudo para me defender e aproveitar o tempo de recuo para atacar', 'Minha magia está no máximo, só preciso apertar Tab e poderei acabar com esses lobos bem mais rápido', 'Tem batatas ali, acho que posso levar algumas para casa hoje também', 'Não!!!! A vila toda está pegando fogo', 'Quem era aquela pessoa? Ela foi nessa direção...', 'O que é isso? Um pilar? O que devo fazer com isso? Atacar?', 'Esqueletos gigantes? Nunca vi esses monstros por essas terras, algo de errado não está certo', 'Meu escudo não funciona nessas coisas, então tudo que me resta é esperar ele parar de atacar e assim agir', 'Mais uma dessas coisas estranhas, se quero descobrir a verdade sobre terei que ir em direção ao desconhecido', 'Quem é voce? Diga logo o porque fez isso!', 'Eu? Eu sou você! Um feitiço da natureza que deu errado, trazemos a vida e entregamos a morte, eu sou o caos, e sou o seu oposto e ao mesmo tempo sou parte de ti, meu destino e sempre reinar no final dos mundos, não importa quantos universos nação ou morram, sempre nos encontramos no fim. Até mais heroi... até o proximo ato desse ritual doentio e sem fim...']

var page = 0
var max_page = 0

#func _ready():
#	$TextureRect/RichTextLabel.bbcode_text = dialog[page]
#	$TextureRect/RichTextLabel.visible_characters = 0
#	set_process_input(true)
#
func _input(event):
	if Input.is_action_just_pressed("ui_enter"):
		if $TextureRect/RichTextLabel.visible_characters > $TextureRect/RichTextLabel.get_total_character_count():
			if page < max_page:
				page += 1
				$TextureRect/RichTextLabel.bbcode_text = dialog[page]
				$TextureRect/RichTextLabel.visible_characters = 0
			if page >= max_page:
				$TextureRect.visible = false

		else:
			$TextureRect/RichTextLabel.visible_characters = $TextureRect/RichTextLabel.get_total_character_count()
				
func _on_Timer_timeout() -> void:
	$TextureRect/RichTextLabel.visible_characters += 1
		
#func _process(delta):
#	$"TextureRect/next-indicator".visible = finished
#	if Input.is_action_just_pressed("ui_enter") and finished == true:
#		load_dialog()
#
#func load_dialog():
#	if dialog_index < dialog.size():
#		finished = false
#		$TextureRect/RichTextLabel.bbcode_text = dialog[dialog_index]
#		$TextureRect/RichTextLabel.percent_visible = 0
#		$TextureRect/Tween.interpolate_property($TextureRect/RichTextLabel, "percent_visible", 0, 1, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
#		$TextureRect/Tween.start()	
#	else:
#		queue_free()
#	dialog_index += 1
#
#func _on_Tween_tween_completed(object, key):
#	finished = true

func _on_Area2D2_area_entered(area: Area2D) -> void:
	$TextureRect.visible = true
	talk(0,0)
	
func talk(begin, end):
	page = begin
	max_page = end
	$TextureRect/RichTextLabel.bbcode_text = dialog[page]
	$TextureRect/RichTextLabel.visible_characters = 0
	set_process_input(true)	

func _on_1_area_entered(area: Area2D) -> void:
	$TextureRect.visible = true
	talk(1,1)

func _on_2_area_entered(area: Area2D) -> void:
	$TextureRect.visible = true
	talk(3,3)

func _on_3_area_entered(area: Area2D) -> void:
	$TextureRect.visible = true
	talk(4,4)
