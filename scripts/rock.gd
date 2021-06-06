extends Area2D

export var vel = 30

var live = true

var damage = 10
#dano dessa bala

func _ready() -> void:
	pass 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	translate(Vector2(0,1) * vel * delta)
	
func autodestroy():
	#para de emitir fumaça
	live = false
	#determina a morte da bala
	queue_free()	

func _on_rock_area_entered(area: Area2D) -> void:
	if area.collision_layer == 1:
		if area.has_method("hit"):
			area.hit(damage, self)
			autodestroy()
