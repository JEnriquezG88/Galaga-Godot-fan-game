extends Node3D

var aliens : Array
var firstTarget : Vector3 = Vector3(-13.0, 0.0, 37.0)
var attack : bool
var canAttack : bool = true
@onready var attackSound: AudioStreamPlayer3D = $Attack
@onready var captureSound: AudioStreamPlayer3D = $Capture
var canReplaceSound : bool = true

signal captured
signal capturedUI
signal addLife

func initAliens() -> void:
	for aliensRow in aliens:
		for alien in aliensRow:
			alien.zOffsetTentative = alien.targetPosition.z - firstTarget.z
			if alien.targetPosition.x < 0:
				alien.xOffsetTentative = alien.targetPosition.x - firstTarget.x
				alien.initPath("res://enemies/generalPaths/down_right_init.tres")
			else:
				alien.xOffsetTentative = alien.targetPosition.x + firstTarget.x
				alien.initPath("res://enemies/generalPaths/down_left_init.tres")
			alien.state = States.AlienStates.INITIALIZE
		spawnAllRightLeft()

func spawnAllRightLeft():
	spawnRightZone()
	await get_tree().create_timer(3.0).timeout
	spawnLeftZone()
	await get_tree().create_timer(3.0).timeout
	attack = true

func spawnRightZone():
	for aliensRow in aliens:
		for alien in aliensRow:
			if alien.targetPosition.x < 0:
				await get_tree().create_timer(0.1).timeout
				if alien.state == States.AlienStates.INITIALIZE: alien.state = States.AlienStates.MOVE_TO_TARGET

func spawnLeftZone():
	for aliensRow in aliens:
		for alien in aliensRow:
			if alien.targetPosition.x > 0:
				await get_tree().create_timer(0.1).timeout
				if alien.state == States.AlienStates.INITIALIZE: alien.state = States.AlienStates.MOVE_TO_TARGET

func enemyAttack():
	if canAttack && !Level.gameOver:
		var iterations : int = 0
		for aliensRow in aliens:
			for alien in aliensRow:
				if alien.state == States.AlienStates.ALIVE:
					iterations+=1
		var attackAlien = randi_range(0, iterations - 1)
		iterations = 0
		for aliensRow in aliens:
			for alien in aliensRow:
				iterations+=1
				if iterations == attackAlien && alien.state == States.AlienStates.ALIVE:
					attackSound.pitch_scale = randf_range(0.5,1.5)
					attackSound.play()
					alien.state = States.AlienStates.ATTACK
		#attackAlien = randi_range(0, iterations - 1)/10
		attackAlien = randi_range(3,5)
		
		await get_tree().create_timer(attackAlien/2).timeout
		enemyAttack()

func _process(delta: float) -> void:
	if attack:
		attack = false
		enemyAttack()

func dead() -> void:
	var parent = get_parent_node_3d()
	parent.dead()

func _on_player_dead_event() -> void:
	canAttack = false

func capturingSounds(value):
	if canReplaceSound:
		captureSound.stream = value
		captureSound.play()
