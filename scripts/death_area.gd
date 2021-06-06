extends Area2D

var damage = 4000

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_death_area_area_entered(area: Area2D) -> void:
	if area.has_method("hit"):
		area.hit(damage, self)
