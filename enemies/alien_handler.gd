extends Node3D

var aliens : Array
var totalAliens : int = 0
var firstTarget : Vector3 = Vector3(-13.0, 0.0, 37.0)
var attack : bool
var canAttack : bool = true
@onready var attackSound: AudioStreamPlayer3D = $Attack
@onready var captureSound: AudioStreamPlayer3D = $Capture
var canReplaceSound : bool = true
var deadAliens : int = 0
var playing : bool = false

signal captured
signal capturedUI
signal addLife
signal addSpaceship
signal newLevel

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
	playing = true

func spawnAllRightLeft():
	spawnRightZone()
	await get_tree().create_timer(3.0).timeout
	spawnLeftZone()
	await get_tree().create_timer(4.0).timeout
	attack = true
	canAttack = true

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
	var liveAliensId : Array
	if canAttack && !Level.gameOver:
		var iterations : int = 0
		for aliensRow in aliens:
			for alien in aliensRow:
				if alien.state == States.AlienStates.ALIVE:
					liveAliensId.append(iterations)
				iterations+=1
		var attackAlien = 0
		if liveAliensId.size() > 1:
			attackAlien = randi() % liveAliensId.size()
		elif liveAliensId.size() > 0:
			attackAlien = 0
		if liveAliensId.size() > 0:
			if attackAlien < liveAliensId.size():
				if liveAliensId[attackAlien]:
					iterations = 0
					for aliensRow in aliens:
						for alien in aliensRow:
							if iterations == liveAliensId[attackAlien] && alien.state == States.AlienStates.ALIVE:
								attackSound.pitch_scale = randf_range(0.8,1.2)
								attackSound.play()
								alien.state = States.AlienStates.ATTACK
							iterations+=1
		var time = randi_range(0.1, 50)/10
		await get_tree().create_timer(time/2).timeout
		enemyAttack()

func _process(delta: float) -> void:
	if attack:
		attack = false
		enemyAttack()
	if deadAliens == totalAliens && playing:
		canAttack = false
		Level.newLevel()
		deadAliens = 0
		newLevel.emit()

func dead() -> void:
	var parent = get_parent_node_3d()
	parent.dead()

func _on_player_dead_event() -> void:
	canAttack = false

func capturingSounds(value):
	if canReplaceSound:
		captureSound.stream = value
		captureSound.play()
