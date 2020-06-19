extends ColorRect

onready var init_rect_size = rect_size
#pega o tamanho inicial do retângulo

var scale = 1 setget set_scale
#definimos o valor 1 como a escala inicial

func _draw() -> void:
	#cria um retângulo preto em volta da barra de vida pra quando ela diminuir ter uma marcação em volta
	draw_rect(Rect2(Vector2(), init_rect_size), Color(0,0,0,1), false)
	#é false porque não é preenchido, é somente uma linha
	
func _ready() -> void:
	POWER.connect("power_changed", self, "on_power_changed")

func on_power_changed(po):
	#essa função será executada toda vez que um sinal com o valor da escala for mandado
	set_scale(po)
	
func set_scale(val):
	#serve pra mudar o valor da escala e verificar quando isso for feito pra mudar o tamanho do retângulo
	scale = val
	if scale > 1:
		scale = 1
	rect_size.x = init_rect_size.x * scale
