extends KinematicBody2D

#algumas explicações estão em "enemy.gd"

export var velocity = Vector2(0,70)

export var gravity = 500

const UP = Vector2(0, -1)

var direction = 0

signal life_scale(sc)

export var life = 100

onready var init_life = life
	
var is_attacking = false

var damage = 10

var olhar_esquerda = false

var olhar_direita = true

export var speed = 50
#velocidade do personagem sem contar a direção

func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	
	if Input.is_action_pressed("ui_right"):
		#se o botão da direita estiver apertado
		if is_attacking == false:
			#se ele não estiver atacando
			$HumanBase2.flip_h = false
			#sprite é invertido na horizontal
			olhar_direita = true
			olhar_esquerda = false
			$AnimationPlayer.play("walk")
			direction = Input.get_action_strength("ui_right") 
			#pega a força do botão da direita e armazena direção
			 
	elif Input.is_action_pressed("ui_left"):
		if is_attacking == false:
			olhar_direita = false
			olhar_esquerda = true
			$HumanBase2.flip_h = true
			$AnimationPlayer.play("walk")
			direction =  -Input.get_action_strength("ui_left")
			
	else: 
		#se nenhum dos dois estiverem apertados:
		direction = 0
		#direção zera(fica parado)
		if is_attacking == false:
			#se ele não estiver atacando
			$AnimationPlayer.play("stand_side")
			
	if Input.is_action_just_pressed("ui_attack") and is_attacking == false:
		#espaço é o botão de ataque
		
		#dependendo da onde ele estiver olhando, sua área de ataque mudará
		if olhar_direita:
			$attack/esquerda.disabled = true
			$attack/direita.disabled = false
		
		if olhar_esquerda:
			$attack/esquerda.disabled = false
			$attack/direita.disabled = true	
		
		#como ele apertou o botão de espaço, agora ele está atacando			
		is_attacking = true
		
		if is_attacking:
			#se ele estiver atacando, ele não se movimenta
			direction = 0
			
		$AnimationPlayer.play("attack")
		yield($AnimationPlayer, "animation_finished")
		#espera a animação de atacar acabar
		$attack/direita.disabled = true
		$attack/esquerda.disabled = true
		#desativa as duas áreas de ataque
		is_attacking = false
		#como ele parou de atacar, o "is_attacking" se torna false
		
#	if $attack/direita.disabled == false:
#		$attack/direita.visible = false
			
	velocity.x = speed * direction
	#multiplica a speed pela direção (direção pode ser -1,1 ou 0)
	
	move_and_slide(velocity, UP)

func _on_damage_area_damage(damage, node) -> void:
	life -= damage
	emit_signal("life_scale", (float(self.life) / float(self.init_life)))

func _on_attack_area_entered(area: Area2D) -> void:
	if area.has_method("hit"):
		area.hit(damage, self)


