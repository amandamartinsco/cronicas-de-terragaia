extends Area2D

signal damage(damage, node)
#sinal tem dois parâmetros, o dano que é dado e quem deu esse dano
#podemos identificar quem deu esse dano

func hit(damage, node):
	emit_signal("damage", damage, node)
	#emite o sinal toda vez que a função é executada
	
#quando um objeto (espada, por exemplo), bater em uma área de um inimigo, será verificado se este inimigo tem o método hit
#se ele tiver o método hit, o método é executado e os parâmetros são recebidos

#para cadastrar o dano recebido é conectado o signal damage, e é feito o cálculo: life -= damage
