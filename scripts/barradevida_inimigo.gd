extends ColorRect

#exatamente a mesma lógica do "barradevida"

onready var init_rect_size = rect_size

var scale = 1 setget set_scale

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_parent().connect("life_scale_enemy", self, "on_life_scale")
	pass
	
func _draw() -> void:
	draw_rect(Rect2(Vector2(), init_rect_size), Color(1,1,1,1), false)

func on_life_scale(sc):
	set_scale(sc)
	
func set_scale(val):
	scale = val
	rect_size.x = init_rect_size.x * scale
