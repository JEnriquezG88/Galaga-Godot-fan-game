extends Node3D

@onready var alien_handler: Node3D = $AlienHandler

var iterations : int = 0
var rowIterations : int = 0
var alien

func _ready() -> void:
	generateAliens()

func generateAliens():
	for target in Level.targets:
		var aliensRow : Array
		var internalIterations : int
		for targetPosition in target:
			alienSelector()
			alien_handler.add_child(alien)
			aliensRow.append(alien)
			alien.id = iterations
			alien.targetPosition = targetPosition
			iterations+=1
		alien_handler.aliens.append(aliensRow)
		rowIterations+=1
	alien_handler.initAliens()

func alienSelector() -> void:
	if rowIterations == 0: alien = preload("res://enemies/diferent/green_alien.tscn").instantiate()
	elif (rowIterations < 3): alien = preload("res://enemies/diferent/red_alien.tscn").instantiate()
	else: alien = preload("res://enemies/diferent/yellow_alien.tscn").instantiate()
