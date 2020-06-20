extends Area2D

export var vel = 30

var max_dist = 100

var dir: Vector2 setget set_dir

onready var init_pos = global_position
#onready = executado dentro do _ready = acontece antes de tudo

var live = true

var damage = 10
#dano dessa bala

func _ready() -> void:
	pass 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if live == true:
		#só faz esse cálculo caso a bala ainda eista
		if global_position.distance_to(init_pos) >= max_dist:
			#distance_to é a distância entre os vetores
			autodestroy()
			
		translate(dir * vel * delta)
		#só vai se mexer se estiver viva

func set_dir(val):
	dir =  val
	rotation = dir.angle()
	#o tiro vai pra rotação semelhante a gerada pela direção
	#todo Vector 2 consegue gerar um angle()

func _on_shoot_poison_body_entered(body: Node) -> void:
	if body.collision_layer == 1:
		#é 4 mas tem q ver quando passa o mouse em cima
		autodestroy()
	
func autodestroy():
	#para de emitir fumaça
	live = false
	#determina a morte da bala
	queue_free()	

func _on_shoot_poison_area_entered(area: Area2D) -> void:
	if area.collision_layer == 1:
		if area.has_method("hit"):
			area.hit(damage, self)
			autodestroy()	
