extends Node

var aliens : Array

func initAliens() -> void:
	for aliensRow in aliens:
		for alien in aliensRow:
			alien.initPath("Hola")
			alien.state = States.AlienStates.INITIALIZE
	for aliensRow in aliens:
		for alien in aliensRow:
			await get_tree().create_timer(0.5).timeout
			alien.state = States.AlienStates.MOVE_TO_TARGET
