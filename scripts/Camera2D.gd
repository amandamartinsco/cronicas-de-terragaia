extends Camera2D

var intensity
#intensidade da vibração
var rot_ang = 0
#angulo de rotação da vibração

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process(false)
	#primeira vez q abre o código, determina o _process como false
	add_to_group("camera")
	#adiciona no gp camera

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rot_ang += PI / 3
	offset = Vector2(sin(rot_ang), cos(rot_ang)) * intensity
	#n sei muito bem o que é offset
	#basicamente o _process só serve para controlar a vibração nesse caso
	
func shake(intensity, duration):
	rot_ang = 0
	set_process(true)
	#começa a vibração
	self.intensity = intensity
	#iguala a intensidade dessa prog com a dada pela função de outra explosão
	get_tree().create_timer(duration).connect("timeout", self, "on_timeout")
	#cria um timer, faz ele funcionar, determina sua duração e conecta seu fim com a função abaixo
	
func on_timeout():
	set_process(false)
	#para a vibração
