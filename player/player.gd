extends Node3D

@onready var spacechip_controller: Node3D = $spacechipController
var spacechips : Array
var maxMovementDistance : float = 20.0
var movement : float = 0.0
var movementVelocity : float = 30.0
var newPositionForNewShip : float = 0.0
var states = States.PlayerStates.IDLE
@onready var player_audio: AudioStreamPlayer3D = $PlayerAudio
@onready var livesContainer: Node3D = $Lives
var lives : int = 0
@onready var player_target: MeshInstance3D = $PlayerTarget
@onready var effects: AudioStreamPlayer3D = $Effects
var checkSpaceshipsPosition : bool = false

signal deadEvent
signal addLive

func _process(delta: float) -> void:
	player_target.position = spacechip_controller.position
	#if checkSpaceshipsPosition:
	checkSpaceshipsPositionFunction(delta)
	if Level.score > Level.liveScore:
		Level.liveScore = Level.liveScore * 2
		setLives(1)
	match states:
		States.PlayerStates.PLAYING:
			checkSpaceshipsPosition = false
			spacechipMovement(delta)
		States.PlayerStates.ON_NEW_SHIP:
			spacechipPosition(delta)
		States.PlayerStates.CAPTURE:
			checkSpaceshipsPosition = true

func checkSpaceshipsPositionFunction(delta: float):
	getSpaceships()
	if spacechips.size() > 0:
		var iterations : int = 0
		var firstSpaceshipPosition : Vector3
		var nextPosition : Vector3
		for spaceship in spacechips:
			if iterations == 0:
				firstSpaceshipPosition = spaceship.position
			else:
				spaceship.position.x = lerp(spaceship.position.x, firstSpaceshipPosition.x - 3 * iterations, 2 * delta)
				spaceship.position.z = lerp(spaceship.position.z, 0.0, 2 * delta)
			iterations += 1

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Shoot"):
		shoot()

func setSpaceshipCollisions(value: bool) -> void:
	getSpaceships()
	if spacechips.size() > 0:
		for spacechip in spacechips:
			spacechip.setCollision(value)

func addSpacechip() -> void:
	setSpaceshipCollisions(false)
	var spacechip = (preload("res://player/model/spacechip_model.tscn")).instantiate()
	if spacechips.size() == 0:
		movement = 0
	else:
		newPositionForNewShip = spacechip_controller.position.x + 3
		spacechip.position.x = 3 * -spacechips.size()
	spacechips.append(spacechip)
	spacechip.position.z = -10.0
	spacechip_controller.add_child(spacechip)
	states = States.PlayerStates.ON_NEW_SHIP

func getSpaceships() -> void:
	spacechips = spacechip_controller.get_children() 

func spacechipPosition(delta: float) -> void:
	getSpaceships()
	if spacechips.size() > 0:
		var currentSpaceship = spacechips[spacechips.size() - 1]
		currentSpaceship.position.z = lerp(currentSpaceship.position.z, 0.0, 10 * delta)
		if spacechip_controller.position.x < 20:
			spacechip_controller.position.x = lerp(spacechip_controller.position.x, newPositionForNewShip, 10 * delta)
		if spacechip_controller.position.x >= 20:
			spacechip_controller.position.x = 20
		if abs(currentSpaceship.position.z) <= 0.1:
			movement = spacechip_controller.position.x
			currentSpaceship.position.z = 0.0
			
			setSpaceshipCollisions(true)
			spaceshipRotation(true)
			states = States.PlayerStates.PLAYING

func spacechipMovement(delta: float) -> void:
	movement -= GlobalInput.leftAxis.x * movementVelocity * delta
	movement = clamp(movement, -20 + (spacechips.size() - 1) * 3, 20)
	spacechip_controller.position.x = movement
	#player_target.position = spacechip_controller.position
	GlobalReferences.player_controller_position = spacechip_controller.position

func spaceshipRotation(value : bool) -> void:
	if spacechips.size() > 0:
		for i in spacechips : 
			i.canRotate = value

func shoot() -> void:
	if states == States.PlayerStates.PLAYING:
		getSpaceships()
		if spacechips.size() > 0:
			player_audio.stream = preload("res://player/effects/shoot.mp3")
			player_audio.play()
			for i in spacechips:
				var bullet = (preload("res://player/playerAssets/bullet.tscn")).instantiate()
				bullet.position.x = spacechip_controller.position.x + i.position.x
				bullet.position.z = 1.9
				add_child(bullet)

func dead(spaceshipDestroy: bool):
	if spaceshipDestroy:
		var spaceship_destroy = preload("res://player/model/spaceship_destroy.tscn").instantiate()
		spaceship_destroy.position = Vector3(spacechip_controller.position.x,spacechip_controller.position.y,spacechip_controller.position.z + 0.7)
		get_parent_node_3d().add_child(spaceship_destroy)
	await get_tree().create_timer(0.1).timeout
	getSpaceships()
	if spacechips.size() == 0:
		if lives > 0:
			setLives(-1)
			setSpaceships()
		else:
			Level.gameOver = true
			deadEvent.emit()
	else:
		ChangeControllerAndSpaceshipsPosition()

func ChangeControllerAndSpaceshipsPosition() -> void:
	getSpaceships()
	var iterations : int = 0
	var leftSpaceshipPosition : Vector3
	for spaceship in spacechips:
		if iterations == 0:
			leftSpaceshipPosition = spaceship.position
		spaceship.position.x += abs(leftSpaceshipPosition.x)
		iterations+=1
	if leftSpaceshipPosition.x != 0:
		movement += leftSpaceshipPosition.x
	states = States.PlayerStates.PLAYING
	setSpaceshipCollisions(true)

func setLives(livesNumber : int):
	if livesNumber == 1:
		addLive.emit()
		effects.stream = preload("res://player/effects/extraLife.mp3")
		effects.play()
	var livesCount = livesContainer.get_children()
	if livesCount.size() > 0:
		for live in livesCount:
			livesContainer.remove_child(live)
	lives += livesNumber
	var iterations : int = 0
	for live in lives: 
		var liveSpaceship = preload("res://player/model/lives.tscn").instantiate()
		liveSpaceship.position = Vector3(21 - 1.5 * iterations,0,-3.5)
		liveSpaceship.scale = Vector3(0.5,0.5,0.5)
		livesContainer.add_child(liveSpaceship)
		iterations+=1

func setSpaceships():
	spacechip_controller.position.x = 0
	var liveSpaceships = spacechip_controller.get_children()
	spacechips = liveSpaceships
	addSpacechip()

func _on_control_start_game() -> void:
	setLives(2)
	setSpaceships()
	#addSpacechip()

func _on_alien_handler_captured() -> void:
	dead(false)

func _on_alien_handler_add_life() -> void:
	setLives(1)

func _on_alien_handler_add_spaceship() -> void:
	effects.stream = preload("res://player/effects/extraLife.mp3")
	effects.play()
	addSpacechip()
