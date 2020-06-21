extends Area2D

var rot_vel = PI*2

var vel = 20
var target

var target_slow = false
var target_fast = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	yield(get_tree().create_timer(0.6), "timeout")
	target_slow = true
	target_fast = false
	yield(get_tree().create_timer(0.3), "timeout")
	target_slow = false
	target_fast = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if target:
	#detecta se tem alguém pra mirar
		rot_vel = PI * 2
		#se pode começar a mirar
		var angle = get_angle_to(target.global_position) 
		if abs(angle) > 0.01:
			rotation += rot_vel * delta * sign(angle) 
			#roda até o alvo com 50 de velocidade * o ângulo entre eles	
					
				
	translate(Vector2(cos(rotation), sin(rotation)).normalized() * vel * delta)
	#é o que faz o tiro se movimentar e n ficar parado

func _on_rock_area_entered(area: Area2D) -> void:
	if area.has_method("hit"):
		area.hit(15, self)
	#se ele estrar na área de outro objeto destructable, ele se destrói e dá dano para aqle objeto
		queue_free()
