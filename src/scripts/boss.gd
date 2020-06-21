extends KinematicBody2D

export var life = 200
#vida do inimigo

onready var init_life = life
#guarda a vida inicial

signal life_scale_boss(sc)

var pre_rock = preload("res://scenes/rock.tscn")

var bodies = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if bodies.size() > 0:
		if $shoot_timer.is_stopped():
			$shoot_timer.start()
	$AnimationPlayer.play("stand")

func _on_weak_spots_damage(damage, node) -> void:
		life -= damage
#		emit_signal("life_scale_boss", (float(self.life) / float(self.init_life)))

func _on_sensor_weak_area_entered(area: Area2D) -> void:
	position += Vector2(50,0)
	$AnimationPlayer.play("fade")

func _on_sensor_attack_body_entered(body: Node) -> void:
	bodies.append(body)

func _on_shoot_timer_timeout() -> void:
	fire()
	
func fire():
	if bodies.size() > 0:
		var rock = pre_rock.instance()
		add_child(rock)
		rock.rotation = rotation
		rock.global_position = $Position2D.global_position
		rock.target = bodies[0]
	else:
		$shoot_timer.stop()
