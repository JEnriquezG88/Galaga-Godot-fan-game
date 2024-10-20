extends alien

@onready var capture_container: Node3D = $CaptureContainer

var spaceship : Node3D
var spaceshipRotation : bool = false
var hasSpaceship = false
var trackBeam
const ALIEN_TRACTOR = preload("res://enemies/effects/AlienTractor.mp3")
const CAPTURING = preload("res://enemies/effects/capturing.mp3")
const CAPTURE = preload("res://enemies/effects/capture.mp3")

func _process(delta: float) -> void:
	if !addSpaceship:
		if hasSpaceship:
			hasSpaceship = false
			spaceship.queue_free()
	match state:
		States.AlienStates.INITIALIZE:
			initialize()
		States.AlienStates.MOVE_TO_TARGET:
			moveToTarget(delta)
		States.AlienStates.ALIVE:
			attack = 0
			endUniqueAttack = false
		States.AlienStates.ATTACK:
			attackSelectorFunction(delta)
		States.AlienStates.CAPTURE:
			if endUniqueAttack:
				returnToTarget(delta)
		States.AlienStates.CAPTURING:
			capturing(delta)
		States.AlienStates.RESPAWN:
			respawn(delta)
	if spaceshipRotation && hasSpaceship:
		spaceship.rotation = model.rotation

func attackSelectorFunction(delta):
	if !endUniqueAttack:
		if hasSpaceship:
			basicAttack(delta)
		else:
			if attack == 0:
				attack = randi_range(1,10)
			if attack % 2:
				uniqueAttack(delta)
			else:
				basicAttack(delta)
	else:
		returnToTarget(delta)

func uniqueAttack(delta):
	var rotationVelocity : float = 5
	if position.z > 10:
		player_direction.look_at(Vector3(GlobalReferences.player_controller_position.x + 5,GlobalReferences.player_controller_position.y,GlobalReferences.player_controller_position.z))
		model.rotation.y = lerp_angle(model.rotation.y, player_direction.rotation.y + PI, rotationVelocity * delta)
		var direction = model.basis.z.normalized()
		position += direction * 40 * delta
	else:
		model.rotation.y = lerp_angle(model.rotation.y, 0.0, rotationVelocity * delta)
		if abs(abs(model.rotation.y) - 2 * PI) < 0.01 || abs(abs(model.rotation.y) - 2 * PI) > (2 * PI - 0.01):
			state = States.AlienStates.CAPTURE
			capture()

func capture():
	trackBeam = preload("res://enemies/effects/tract_beam.tscn").instantiate()
	trackBeam.position.z = 0
	trackBeam.setScale(1.0)
	add_child(trackBeam)
	var capture = preload("res://enemies/capture.tscn").instantiate()
	get_parent_node_3d().capturingSounds(ALIEN_TRACTOR)
	capture.position.z = -6
	capture_container.add_child(capture)
	await get_tree().create_timer(2).timeout
	capture_container.remove_child(capture)
	#if !captureSpaceship:
	if !addSpaceship:
		trackBeam.setScale(0.0)
	endUniqueAttack = true

func onCaptured(initialPosition: Vector3):
	get_parent_node_3d().capturingSounds(CAPTURING)
	get_parent_node_3d().canReplaceSound = false
	addSpaceship = true
	get_parent_node_3d().canAttack = false
	spaceshipRotation = false
	captureSpaceship = true
	var redSpaceship = preload("res://enemies/red_spaceship.tscn").instantiate()
	hasSpaceship = true
	redSpaceship.position = initialPosition
	spaceship = redSpaceship
	spaceship.scale = Vector3(0.5,0.5,0.5)
	add_child(redSpaceship)
	state = States.AlienStates.CAPTURING

func capturing(delta):
	if spaceship.rotation.y < 20 * PI:
		spaceship.rotation.y += 20 * delta
	elif spaceship.position.z < 2.0:
		trackBeam.setScale(0.0)
		spaceship.position.z = lerp(spaceship.position.z, 2.1,10 * delta)
	else:
		get_parent_node_3d().canReplaceSound = true
		get_parent_node_3d().capturingSounds(CAPTURE)
		get_parent_node_3d().canReplaceSound = false
		spaceshipRotation = true;
		endUniqueAttack = true
		state = States.AlienStates.CAPTURE
		get_parent_node_3d().capturedUI.emit()
		await get_tree().create_timer(4.33).timeout
		get_parent_node_3d().canReplaceSound = true
		get_parent_node_3d().captured.emit()
		get_parent_node_3d().canAttack = true
		get_parent_node_3d().enemyAttack()

func returnToTarget(delta):
	if position.z < 100:
		position.z += 40 * delta
	else:
		endUniqueAttack = false
		position = targetPosition + Vector3(0,0,20)
		model.rotation.y = PI
		state = States.AlienStates.RESPAWN
