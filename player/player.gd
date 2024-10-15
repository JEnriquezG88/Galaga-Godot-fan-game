extends Node3D

@onready var spacechip_controller: Node3D = $spacechipController
var spacechips : Array
var maxMovementDistance : float = 20.0
var movement : float = 0.0
var movementVelocity : float = 30.0
var newPositionForNewShip : float = 0.0
var states = States.PlayerStates.IDLE

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Back"):
		addSpacechip()
	if Input.is_action_just_pressed("Shoot"):
		shoot()
	match states:
		States.PlayerStates.PLAYING:
			spacechipMovement(delta)
		States.PlayerStates.ON_NEW_SHIP:
			spacechipPosition(delta)

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
		spaceshipRotation(true)
		states = States.PlayerStates.PLAYING

func spacechipMovement(delta: float) -> void:
	movement -= GlobalInput.leftAxis.x * movementVelocity * delta
	movement = clamp(movement, -20 + (spacechips.size() - 1) * 3, 20)
	spacechip_controller.position.x = movement
	GlobalReferences.player_controller_position = spacechip_controller.position

func spaceshipRotation(value : bool) -> void:
	if spacechips.size() > 0:
		for i in spacechips : 
			i.canRotate = value

func shoot() -> void:
	for i in range(spacechips.size()):
		var bullet = (preload("res://player/playerAssets/bullet.tscn")).instantiate()
		bullet.position.x = spacechip_controller.position.x - 3 * i
		bullet.position.z = 1.9
		add_child(bullet)
