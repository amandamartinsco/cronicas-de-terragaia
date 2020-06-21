extends KinematicBody2D

export var velocity = Vector2(10,70)

export var gravity = 100

const UP = Vector2(0, -1)

var damage = 30
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

var is_attacking = false

func _ready() -> void:
	velocity.x = - velocity.x
	#começa andando pra esqueda
	set_physics_process(false)
	#começa desativado, só será ativado quando o inimigo entrar na tela

func _physics_process(delta: float) -> void:
	
	velocity.y = gravity
	#a velocidade no eixo y é equivalente à gravidade

	if is_on_wall():
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
		if !is_attacking:
			$AnimationPlayer.play("walk_right")

	if olhar_esquerda:
		if !is_attacking:
			$AnimationPlayer.play("walk_left")

	move_and_slide(velocity, UP)
	
	#se ele entrar na tela, a física começa a funcionar
func _on_VisibilityNotifier2D_screen_entered() -> void:
	set_physics_process(true)

	#se ele sair da tela, a física para de funcionar
func _on_VisibilityNotifier2D_screen_exited() -> void:
	set_physics_process(false)

func _on_weak_spot_damage(damage, node) -> void:
		life -= damage
		emit_signal("life_scale_enemy", (float(self.life) / float(self.init_life)))
		#escala é mandado pra escala da barra de vida
		if life <= 0:
			#yield($AnimationPlayer, "animation_finished")
			emit_signal("pode_dropar", $".".position) 
			#o sinal é mandado indicando que é possível dropar o item agora
			queue_free()

func _on_attack_timeout() -> void:
	if !is_attacking:
		print("atacando")
		attack()
	
func attack():
	is_attacking = true
	if olhar_direita:
		$AnimationPlayer.play("attack_right")
		$Area2D/esquerda.disabled = true
		$Area2D/direita.disabled = false
		yield($AnimationPlayer, "animation_finished")
		$Area2D/esquerda.disabled = true
		$Area2D/direita.disabled = true
		is_attacking = false
	if olhar_esquerda:
		$AnimationPlayer.play("attack_left")
		$Area2D/esquerda.disabled = false
		$Area2D/direita.disabled = true
		yield($AnimationPlayer, "animation_finished")
		$Area2D/esquerda.disabled = true
		$Area2D/direita.disabled = true
		is_attacking = false


func _on_Area2D_area_entered(area: Area2D) -> void:
	if area.has_method("hit"):
		area.hit(damage, self)
		
