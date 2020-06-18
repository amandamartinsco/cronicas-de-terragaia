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

signal life_scale_enemy(sc)
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
	$RayCast2D.enabled = true
	#ativa o RayCast
	
	velocity.y = gravity
	#a velocidade no eixo y é equivalente à gravidade
	
	if is_on_wall():
		#se ele detectar uma parede
		velocity.x = velocity.x * -1
		#velocidade é invertida no eixo x
		$"RayCast2D".cast_to.x *= -1
		#também inverte a direção do RayCast
		
	if $"RayCast2D".is_colliding():
		#se estiver colidindo
		
		#analisa para qual direção o personagem está olhando e assim define sua nova velocidade
		if velocity.x < 0:
			velocity.x = -30
			$BaseArmoredDemo.flip_h = false
			
		if velocity.x >= 0:
			velocity.x = 30		
			$BaseArmoredDemo.flip_h = true
			
		$AnimationPlayer.play("run")
				
	else:
		#se o RayCast não estiver colidindo
		
		$attack/direita.disabled = true
		$attack/esquerda.disabled = true	
		#desativa as áreas de ataques tanto da esquerda quanto da direita
		
		#diminui a velocidade pela metade e roda a animação de andar ao invés de rodar a de correr
			
		if velocity.x < 0:
			velocity.x = -15
			$BaseArmoredDemo.flip_h = false
			
		if velocity.x >= 0:
			velocity.x = 15		
			$BaseArmoredDemo.flip_h = true
		$AnimationPlayer.play("walk")	
		
	#analisa qual para qual direção está, e dependendo disso define para onde o inimigo está olhando
	if velocity.x >= 0:
		olhar_direita = true
		olhar_esquerda = false
		
	if velocity.x < 0:
		olhar_direita = false
		olhar_esquerda = true
		
	#dependendo da onde ele estiver olhando, sua área de ataque mudará
	if olhar_direita:
		$attack/direita.disabled = false
		$attack/esquerda.disabled = true
		
	if olhar_esquerda:
		$attack/direita.disabled = true
		$attack/esquerda.disabled = false			

	move_and_slide(velocity, UP)
	
	#se ele entrar na tela, a física começa a funcionar
func _on_VisibilityNotifier2D_screen_entered() -> void:
	set_physics_process(true)

	#se ele sair da tela, a física para de funcionar
func _on_VisibilityNotifier2D_screen_exited() -> void:
	set_physics_process(false)

#func _on_Area2D_area_entered(area):
#	emit_signal("pode_dropar", $".".position)

#se a área de ataque encontrar outra área que tem o método hit, ela manda o damage pra ela
func _on_attack_area_entered(area: Area2D) -> void:
	if area.has_method("hit"):
		area.hit(damage, self)

#weak_spot é área em que o inimigo toma dano
#se o weak_spot receber damage de outra área, a vida diminui

func _on_weak_spot_damage(damage, node) -> void:
		life -= damage
		emit_signal("life_scale_enemy", (float(self.life) / float(self.init_life)))
		#escala é mandado pra escala da barra de vidaa
