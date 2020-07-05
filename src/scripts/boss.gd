extends KinematicBody2D

export var life = 200
#vida do inimigo

onready var init_life = life
#guarda a vida inicial

signal life_scale_enemy(sc)

var positions_x = [-35.0, -45.0, -65.0, -75.0, 35.0, 45.0, 65.0, 75.0]

var pre_rock = preload("res://scenes/rock.tscn")

var bodies = []

signal pode_falar(po)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().get_nodes_in_group("dialog")[0].connect("end", self, "finish")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if bodies.size() > 0:
		if $shoot_timer.is_stopped():
			$shoot_timer.start()
	$AnimationPlayer.play("stand")
	
	
	if Input.is_action_just_pressed("ui_page_up"):
		$Sprite2.visible = true
		$Sprite3.visible = true		
		
	if Input.is_action_just_pressed("ui_page_down"):
		$Sprite2.visible = false
		$Sprite3.visible = false	
		
func _on_weak_spots_damage(damage, node) -> void:
		life -= damage
		emit_signal("life_scale_enemy", (float(self.life) / float(self.init_life)))
		if life <= 0:
			emit_signal("pode_falar", true)
			$Sprite2.queue_free()
			$Sprite3.queue_free()
			$barradevida_inimigo.queue_free()
			$sensor_attack.queue_free()
			bodies.clear()
			$shoot_timer.queue_free()
			
#func _on_sensor_weak_area_entered(area: Area2D) -> void:
#	position += Vector2(50,0)
#	$AnimationPlayer.play("fade")

func _on_sensor_attack_body_entered(body: Node) -> void:
	bodies.append(body)

func _on_shoot_timer_timeout() -> void:
	fire()
	
func fire():
	if bodies.size() > 0:
		var rock = pre_rock.instance()
		#ock.dir = Vector2(0,1)
		var choose = rand_range(0, 8)
		choose = int(choose)		
		rock.global_position = global_position + Vector2(positions_x[choose], 0)
		get_parent().add_child(rock)
	else:
		$shoot_timer.stop()
		
func finish(po):
	if po == true:
		get_tree().get_nodes_in_group("dialog")[0].queue_free()
		queue_free()
