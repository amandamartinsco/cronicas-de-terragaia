extends KinematicBody2D

#algumas explicações estão em "enemy.gd"

export var velocity = Vector2(0,70)

export var gravity = 15

export var jump_power = -200

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

var has_sword_bainha = false

var has_just_bainha = false

var can_switch_sword = true

var on_floor = false

var pre_apple = preload("res://scenes/apple_blue.tscn")

signal hasSword(t)

func _ready() -> void:
	if (get_parent().get_filename()) == "res://scenes/enemy.tscn":
		get_tree().get_nodes_in_group("swords")[0].connect("get_sword", self, "got_sword")
	else:
		has_sword_bainha = true
func _physics_process(delta: float) -> void:
	if has_just_bainha or has_sword_bainha:
		emit_signal("hasSword", true)
	else:
		emit_signal("hasSword", false)
#	if has_just_bainha or has_sword_bainha:
#		get_tree().get_nodes_in_group("swords")[0].disconnect("get_sword", self, "got_sword")		
	if is_on_floor():
		on_floor = true
	else:
		on_floor = false
		if !has_just_bainha and !has_sword_bainha:
			if velocity.y < 0:
				$AnimationPlayer.play("jump-sword")
			else:
				$AnimationPlayer.play("fall-sword")
		if has_just_bainha or has_sword_bainha:
			if velocity.y < 0:
				$AnimationPlayer.play("jump")
			else:
				$AnimationPlayer.play("fall")
		
	if Input.is_action_pressed("jump"):
		if on_floor:
			velocity.y = jump_power
			on_floor = false
		
	if Input.is_action_pressed("ui_right"):
		#se o botão da direita estiver apertado
		if is_attacking == false:
			#se ele não estiver atacando
			$HumanBase2.flip_h = false
			#sprite é invertido na horizontal
			olhar_direita = true
			olhar_esquerda = false
			if velocity.y >= 0:
				if has_sword_bainha:
					$AnimationPlayer.play("+sword+bainha")
					$equipedFootsteps.play()
				if has_just_bainha:
					$AnimationPlayer.play("-sword+bainha")
					$unequipedFootsteps.play()
				if !has_just_bainha and !has_sword_bainha:
					$AnimationPlayer.play("-sword-bainha")
					$unequipedFootsteps.play()
			else:
				$unequipedFootsteps.stop()
				$equipedFootsteps.stop()
			direction.x = Input.get_action_strength("ui_right") 
			#pega a força do botão da direita e armazena direção
			 
	if Input.is_action_pressed("ui_left"):
		if is_attacking == false:
			olhar_direita = false
			olhar_esquerda = true
			$HumanBase2.flip_h = true
			if velocity.y >= 0:
				if has_sword_bainha:
					$AnimationPlayer.play("+sword+bainha")
					$equipedFootsteps.play()
				if has_just_bainha:
					$AnimationPlayer.play("-sword+bainha")
					$unequipedFootsteps.play()
				if !has_just_bainha and !has_sword_bainha:
					$AnimationPlayer.play("-sword-bainha")
					$unequipedFootsteps.play()
			else:
				$unequipedFootsteps.stop()
				$equipedFootsteps.stop()
			direction.x =  -Input.get_action_strength("ui_left")
			
	#se ele não estiver apertando direita ou esquerda:
	if !Input.is_action_pressed("ui_left") and !Input.is_action_pressed("ui_right"):
		#se nenhum dos dois estiverem apertados:
		direction.x = 0
		#direção zera(fica parado)
		if can_stand:
			if is_attacking == false:
				#se ele não estiver atacando
				if has_sword_bainha:
					$AnimationPlayer.play("stand_side+sword+bainha")
				if has_just_bainha:
					$AnimationPlayer.play("stand_side-sword+bainha")
				if !has_just_bainha and !has_sword_bainha:
					$AnimationPlayer.play("stand_side-sword-bainha")

	if Input.is_action_just_pressed("ui_attack") and is_attacking == false and has_sword_bainha:
		#J é o botão de ataque
		
		#dependendo da onde ele estiver olhando, sua área de ataque mudará
		if olhar_direita:
			$attack/esquerda.disabled = true
			$attack/direita.disabled = false
			$swordAttack.play()
		
		if olhar_esquerda:
			$attack/esquerda.disabled = false
			$attack/direita.disabled = true	
			$swordAttack.play()
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
	
	if Input.is_action_pressed("ui_sword"):
		can_switch_sword = true
#
	if Input.is_action_just_released("ui_sword"):
		can_switch_sword = false	
			
	if has_sword_bainha and can_switch_sword and !Input.is_action_pressed("ui_left") and !Input.is_action_pressed("ui_right"):
		has_just_bainha = true		
		has_sword_bainha = false
		$AnimationPlayer.play("take_in_sword")
		yield($AnimationPlayer, "animation_finished")					
		
	if has_just_bainha and can_switch_sword and !Input.is_action_pressed("ui_left") and !Input.is_action_pressed("ui_right"):
		has_just_bainha = false
		has_sword_bainha = true
		$AnimationPlayer.play("take_out_sword")
		yield($AnimationPlayer, "animation_finished")
						
	if has_sword_bainha:
		speed = 75
		
	if has_just_bainha:
		speed = 80
	
	if !has_just_bainha and !has_sword_bainha:
		speed = 81
		
	velocity.x = speed * direction.x
	#multiplica a speed pela direção (direção pode ser -1,1 ou 0)
	
	velocity.y += gravity
		
	velocity = move_and_slide(velocity, UP)

func _on_damage_area_damage(damage, node) -> void:
	life -= damage
	emit_signal("life_scale", (float(self.life) / float(self.init_life)))
	$damage.play()
	if life == 0:
		$death.play()
		get_tree().change_scene("res://scenes/gameOver.tscn")

func _on_attack_area_entered(area: Area2D) -> void:
	if area.has_method("hit"):
		area.hit(damage, self)
		$swordHit.play()
		
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
	
func got_sword(boolean):
	if boolean == true:
		has_sword_bainha = true
