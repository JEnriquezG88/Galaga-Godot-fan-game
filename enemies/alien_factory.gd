extends Node3D

@onready var alien_handler: Node3D = $AlienHandler
@onready var alien_audio: AudioStreamPlayer3D = $AlienAudio
@onready var explosion_audio: AudioStreamPlayer3D = $ExplosionAudio

var iterations : int = 0
var rowIterations : int = 0
var alien

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

func dead() -> void:
	const DEAD_1 = preload("res://enemies/effects/dead_1.mp3")
	const DEAD_2 = preload("res://enemies/effects/dead_2.mp3")
	var rand = randi_range(1,10)
	if rand % 2:
		alien_audio.stream = DEAD_1
	else:
		alien_audio.stream = DEAD_2
	alien_audio.play()
	explosion_audio.play()


func _on_control_start_game() -> void:
	generateAliens()
