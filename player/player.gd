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

signal deadEvent

func _process(delta: float) -> void:
	match states:
		States.PlayerStates.PLAYING:
			spacechipMovement(delta)
		States.PlayerStates.ON_NEW_SHIP:
			spacechipPosition(delta)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Shoot"):
		shoot()

func addSpacechip() -> void:
	if spacechips.size() < 10:
		spaceshipRotation(false)
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

func spacechipPosition(delta: float) -> void:
	var currentSpaceship = spacechips[spacechips.size() - 1]
	currentSpaceship.position.z = lerp(currentSpaceship.position.z, 0.0, 10 * delta)
	if spacechip_controller.position.x < 20:
		spacechip_controller.position.x = lerp(spacechip_controller.position.x, newPositionForNewShip, 10 * delta)
	if spacechip_controller.position.x >= 20:
		spacechip_controller.position.x = 20
	if abs(currentSpaceship.position.z) <= 0.1:
		movement = spacechip_controller.position.x
		currentSpaceship.position.z = 0.0
		currentSpaceship.setCollision(false)
		spaceshipRotation(true)
		states = States.PlayerStates.PLAYING

func spacechipMovement(delta: float) -> void:
	movement -= GlobalInput.leftAxis.x * movementVelocity * delta
	movement = clamp(movement, -20 + (spacechips.size() - 1) * 3, 20)
	spacechip_controller.position.x = movement
	player_target.position = spacechip_controller.position
	GlobalReferences.player_controller_position = spacechip_controller.position

func spaceshipRotation(value : bool) -> void:
	if spacechips.size() > 0:
		for i in spacechips : 
			i.canRotate = value

func shoot() -> void:
	if spacechip_controller.get_children().size() > 0:
		player_audio.stream = preload("res://player/effects/shoot.mp3")
		player_audio.play()
		for i in range(spacechips.size()):
			var bullet = (preload("res://player/playerAssets/bullet.tscn")).instantiate()
			bullet.position.x = spacechip_controller.position.x - 3 * i
			bullet.position.z = 1.9
			add_child(bullet)

func dead():
	if lives > 0:
		setLives(lives - 1)
		await get_tree().create_timer(0.1).timeout
		setSpaceships()
	else:
		deadEvent.emit()
	pass

func setLives(livesNumber : int):
	var livesCount = livesContainer.get_children()
	if livesCount.size() > 0:
		for live in livesCount:
			livesContainer.remove_child(live)
	lives = livesNumber
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
	print(liveSpaceships)
	spacechips = liveSpaceships
	addSpacechip()

func _on_control_start_game() -> void:
	setLives(3)
	setSpaceships()
	#addSpacechip()
