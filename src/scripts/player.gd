extends KinematicBody2D

#algumas explicações estão em "enemy.gd"

export var velocity = Vector2(0,70)

export var gravity = 400*11

export var speed_y = 140*9

const UP = Vector2(0, -1)

var direction = Vector2()

signal life_scale(sc)

export var life = 100

onready var init_life = life
	
var is_attacking = false

var damage = 10

var olhar_esquerda = false

var olhar_direita = true

export var speed = 75
#velocidade do personagem sem contar a direção

var can_stand:bool

func _ready() -> void:
	#POWER.add_power(0)
	pass
func _physics_process(delta: float) -> void:
	var is_jump_interrupted = Input.is_action_just_released("jump") and velocity.y < 0
		
	if Input.is_action_just_released("jump"):
		$AnimationPlayer.play("fall")
		yield($AnimationPlayer, "animation_finished")
		can_stand = true
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		can_stand = false
		direction.y = -1.0
		$AnimationPlayer.play("jump")
	else:
		direction.y = 0.0
		
	if Input.is_action_pressed("ui_right"):
		#se o botão da direita estiver apertado
		if is_attacking == false:
			#se ele não estiver atacando
			$HumanBase2.flip_h = false
			#sprite é invertido na horizontal
			olhar_direita = true
			olhar_esquerda = false
			if velocity.y >= 0:
				$AnimationPlayer.play("walk")
			direction.x = Input.get_action_strength("ui_right") 
			#pega a força do botão da direita e armazena direção
			 
	if Input.is_action_pressed("ui_left"):
		if is_attacking == false:
			olhar_direita = false
			olhar_esquerda = true
			$HumanBase2.flip_h = true
			if velocity.y >= 0:
				$AnimationPlayer.play("walk")
			direction.x =  -Input.get_action_strength("ui_left")
			
	#se ele não estiver apertando direita ou esquerda:
	if !Input.is_action_pressed("ui_left") and !Input.is_action_pressed("ui_right"):
		#se nenhum dos dois estiverem apertados:
		direction.x = 0
		#direção zera(fica parado)
		if can_stand:
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
			direction.x = 0
			
		$AnimationPlayer.play("attack")
		yield($AnimationPlayer, "animation_finished")
		#espera a animação de atacar acabar
		$attack/direita.disabled = true
		$attack/esquerda.disabled = true
		#desativa as duas áreas de ataque
		is_attacking = false
		#como ele parou de atacar, o "is_attacking" se torna false
			
	velocity.x = speed * direction.x
	#multiplica a speed pela direção (direção pode ser -1,1 ou 0)
	
	velocity.y = calculate_velocity_y(is_jump_interrupted, speed_y, gravity, direction)
		
	move_and_slide(velocity, UP)

func _on_damage_area_damage(damage, node) -> void:
	life -= damage
	emit_signal("life_scale", (float(self.life) / float(self.init_life)))

func _on_attack_area_entered(area: Area2D) -> void:
	if area.has_method("hit"):
		area.hit(damage, self)
		
func calculate_velocity_y(is_jump_interrupted, speed_y, gravity, direction):
	var new_velocity_y:int
	new_velocity_y += gravity*get_physics_process_delta_time()
	#isso acontece no caso padrão (direção y é 1, ou seja, ele está caindo)
	if direction.y == -1.0:
		#isso acontece na hora que estamos pulando
		new_velocity_y = speed_y * direction.y
	if is_jump_interrupted:
		#isso acontece na hora que paramos de segurar o espaço
		new_velocity_y = 0.0
	return new_velocity_y 	
	
func get_bonus_life(bonus_life):
	life+=bonus_life
	emit_signal("life_scale", (float(self.life) / float(self.init_life)))

