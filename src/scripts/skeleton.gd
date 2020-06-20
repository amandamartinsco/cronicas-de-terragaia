extends KinematicBody2D

export var velocity = Vector2(10,70)

export var gravity = 100

const UP = Vector2(0, -1)

var damage = 10
#dano que o inimigo dá

var olhar_esquerda = false
#é true quando ele está olhando pra esquerda

var olhar_direita = true
#é true quando ele está olhando pra esquerda

signal pode_dropar(pd)
#avisa quando o inimigo pode dropar

signal life_scale_skeleton(sc)
#sinal que mostra a escala da barra de vida do inimigo

export var life = 100
#vida do inimigo

onready var init_life = life
#guarda a vida inicial

func _ready() -> void:
	velocity.x = - velocity.x
	#começa andando pra esqueda
	set_physics_process(false)
	#começa desativado, só será ativado quando o inimigo entrar na tela

func _physics_process(delta: float) -> void:
	
	velocity.y = gravity
	#a velocidade no eixo y é equivalente à gravidade
	
	if is_on_wall():
		print("toquei")
		#se ele detectar uma parede
		velocity.x = velocity.x * -1
		#velocidade é invertida no eixo 	
			
	if velocity.x >= 0:
		olhar_direita = true
		olhar_esquerda = false
		
	if velocity.x < 0:
		olhar_direita = false
		olhar_esquerda = true
		
	if olhar_direita:
		$Sprite.flip_h = true 
		$Sprite.position.x = +20
		$esquerda1.disabled = true	
		$direita1.disabled = false	
		
	if olhar_esquerda:
		$Sprite.flip_h = false
		$Sprite.position.x = -20	
		$direita1.disabled = true
		$esquerda1.disabled = false		
					
	$AnimationPlayer.play("walk")	
					
	move_and_slide(velocity, UP)
	
	#se ele entrar na tela, a física começa a funcionar
func _on_VisibilityNotifier2D_screen_entered() -> void:
	set_physics_process(true)

	#se ele sair da tela, a física para de funcionar
func _on_VisibilityNotifier2D_screen_exited() -> void:
	set_physics_process(false)

func _on_weak_spot_damage(damage, node) -> void:
		life -= damage
		emit_signal("life_scale_skeleton", (float(self.life) / float(self.init_life)))
		#escala é mandado pra escala da barra de vida

