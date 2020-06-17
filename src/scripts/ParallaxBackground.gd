extends ParallaxBackground


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("ui_page_down"):
		$ParallaxLayer/Sprite.visible = true
		$ParallaxLayer2/Sprite.visible = false
		
	elif Input.is_action_pressed("ui_page_up"):
		$ParallaxLayer/Sprite.visible = false
		$ParallaxLayer2/Sprite.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
