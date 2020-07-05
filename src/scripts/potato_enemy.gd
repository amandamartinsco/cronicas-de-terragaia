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

export var life = 50
#vida do inimigo

var pre_shoot = preload("res://scenes/shoot_poison.tscn")

var pre_apple = preload("res://scenes/batata.tscn")

var can_shoot:bool

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
		
	if olhar_esquerda:
		$Sprite.flip_h = false
		
	$AnimationPlayer.play("walk")	
					
#	if can_shoot:
#		print("atirando")
#		shoot()
		
	move_and_slide(velocity, UP)
	
	#se ele entrar na tela, a física começa a funcionar
func _on_VisibilityNotifier2D_screen_entered() -> void:
	set_physics_process(true)
	$shoot.start()

	#se ele sair da tela, a física para de funcionar
func _on_VisibilityNotifier2D_screen_exited() -> void:
	set_physics_process(false)
	$shoot.stop()

func _on_weak_spot_damage(damage, node) -> void:
		life -= damage
		emit_signal("life_scale_enemy", (float(self.life) / float(self.init_life)))
		#escala é mandado pra escala da barra de vidaa
		if life <= 0:
			spawn_maca()
			#yield($AnimationPlayer, "animation_finished")
			emit_signal("pode_dropar", $".".position) 
			#o sinal é mandado indicando que é possível dropar o item agora
			queue_free()
			
func _on_shoot_timeout() -> void:
	get_node("subshoot").start()
	get_node("shoot2").start()

func shoot():
	can_shoot = false
	var poison = pre_shoot.instance()
	poison.global_position = get_node("Position2D").global_position
	$shootSong.play()
	if olhar_direita:
		poison.dir = Vector2(1,0)
	if olhar_esquerda:
		poison.dir = Vector2(-1,0)
	get_parent().add_child(poison)

func _on_subshoot_timeout() -> void:
	get_node("shoot2").stop()

func _on_shoot2_timeout() -> void:
	shoot()
	
func spawn_maca():
	var maca = pre_apple.instance()
	maca.global_position = self.global_position - Vector2(0,20)
	get_parent().add_child(maca)
	#é pra usar call_deferred mas se usar não colisão entre a maçã e o personagem		

