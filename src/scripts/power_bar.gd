extends ColorRect

onready var init_rect_size = rect_size 
#pega o tamanho inicial do retângulo

#var scale = 1 setget set_scale
#definimos o valor 1 como a escala inicial

var power_scale = 0.0 setget set_power_scale

func _ready() -> void:
#	rect_rotation = 180
#	#vira ela 180 graus pra barra descer ao invés de subir
#	rect_position += init_rect_size
	POWER.connect("power_changed", self, "on_power_changed")
	
func _draw() -> void:
	#cria um retângulo preto em volta da barra de vida pra quando ela diminuir ter uma marcação em volta
	draw_rect(Rect2(Vector2(), init_rect_size), Color(0,0,0,1), false)
	#é false porque não é preenchido, é somente uma linha
	draw_rect(Rect2(Vector2(0,.7),Vector2(power_scale, init_rect_size.y-0.7)), Color(1,0,1,1), true)
	print(power_scale)
	
func on_power_changed(po):
	print(po)
	#essa função será executada toda vez que um sinal com o valor da escala for mandado
	set_power_scale(po)
	
func set_power_scale(val):
	#serve pra mudar o valor da escala e verificar quando isso for feito pra mudar o tamanho do retângulo
	power_scale = val*100
	if power_scale > init_rect_size.x:
		power_scale = init_rect_size.x
#	rect_size.x = init_rect_size.x * power_scale
	update()
