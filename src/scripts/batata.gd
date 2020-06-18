extends KinematicBody2D

export var velocity = Vector2(0,70)
export var gravity = 500

var pode_pegar = false #variável pra saber se o player ja pode pegar o item

signal bonus_life(bl)

var life = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.visible = false #O item está invisível
	for i in len(get_tree().get_nodes_in_group("enemy")):
		get_tree().get_nodes_in_group("enemy")[i].connect("pode_dropar", self, "dropar")
	#conecta o sinal pode_dropar de quando o inimigo morre com a função dropar

func dropar(pd):
	$".".position = pd #A posição do item dropado vai ser a posição do inimigo quando morreu
	$Sprite.visible = true #Agora o item está visível
	pode_pegar = true

func _physics_process(delta: float) -> void:
	velocity.y = gravity
	#a velocidade no eixo y é equivalente à gravidade
	move_and_slide(velocity)


func _on_Area2D_area_entered(area):
	if pode_pegar:
		queue_free()

