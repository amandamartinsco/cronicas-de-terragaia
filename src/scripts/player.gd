extends KinematicBody2D

export var velocity = Vector2(0,70)

export var gravity = 500

const UP = Vector2(0, -1)

var direction = 0

signal life_scale(sc)

export var life = 300

onready var init_life = life
	
var is_attacking = false

var damage = 10

var olhar_esquerda = false

var olhar_direita = true

func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:

	if Input.is_action_pressed("ui_right"):
		if is_attacking == false:
			$HumanBase2.flip_h = false
			olhar_direita = true
			olhar_esquerda = false
			$AnimationPlayer.play("walk")
			direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
			
	elif Input.is_action_pressed("ui_left"):
		if is_attacking == false:
			olhar_direita = false
			olhar_esquerda = true
			$HumanBase2.flip_h = true
			$AnimationPlayer.play("walk")
			direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	else: 
		direction = 0
		if is_attacking == false:
			$AnimationPlayer.play("stand_side")
			
	if Input.is_action_just_pressed("ui_attack") and is_attacking == false:
		is_attacking = true
		if is_attacking:
			direction = 0
		$AnimationPlayer.play("attack")
		yield($AnimationPlayer, "animation_finished")
		$attack/direita.disabled = false
		$attack/esquerda.disabled = false
		is_attacking = false
		
			
	velocity.x = 50 * direction
	move_and_slide(velocity, UP)

func _on_damage_area_damage(damage, node) -> void:
	life -= damage
	print(life)
	emit_signal("life_scale", (float(self.life) / float(self.init_life)))

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	is_attacking = false

func _on_AnimationPlayer_animation_started(anim_name: String) -> void:
	if olhar_direita:
		$attack/esquerda.disabled = true
		$attack/direita.disabled = false
		
	if olhar_esquerda:
		$attack/esquerda.disabled = false
		$attack/direita.disabled = true	

func _on_attack_area_entered(area: Area2D) -> void:
	if area.has_method("hit"):
		area.hit(damage, self)

