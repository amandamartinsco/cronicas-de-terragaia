extends Area2D

var inside:bool

signal get_sword(inside)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if inside == true and Input.is_action_just_pressed("ui_accept"):
		on_get_sword()

func _on_pilar_area_entered(area: Area2D) -> void:
	inside = true
	
func on_get_sword():
	emit_signal("get_sword", true)
	$AnimationPlayer.play("disappear")
	queue_free()
	
