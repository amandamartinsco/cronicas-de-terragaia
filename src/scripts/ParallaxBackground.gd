extends ParallaxBackground

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ParallaxLayer/Sprite.visible = true
	$ParallaxLayer2/Sprite.visible = false
	#O ParallaxLayer vai começar visível e o ParallasLayer 2, invisível
	
func _physics_process(delta: float) -> void:
	if POWER.get("power") == 1:
		if Input.is_action_pressed("ui_page_up"):
			$ParallaxLayer/Sprite.visible = false
			$ParallaxLayer2/Sprite.visible = true
			#Quando o player apertar Pg Up, o ParallaxLayer  vai ficar invisível e o ParallaxLayer 2 , visível
			
			
		elif Input.is_action_pressed("ui_page_down"):
			$ParallaxLayer/Sprite.visible = true
			$ParallaxLayer2/Sprite.visible = false
			#Quando o player apertar Pg Up, o ParallaxLayer 2 vai ficar invisível e o ParallaxLayer, visível


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
