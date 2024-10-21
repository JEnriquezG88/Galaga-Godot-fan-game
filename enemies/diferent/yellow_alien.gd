extends alien

var rounds : int = 0

func _process(delta: float) -> void:
	match state:
		States.AlienStates.INITIALIZE:
			initialize()
		States.AlienStates.MOVE_TO_TARGET:
			moveToTarget(delta)
		States.AlienStates.ALIVE:
			shot = false
		States.AlienStates.ATTACK:
			attackSelectorFunction(delta)
		States.AlienStates.RESPAWN:
			respawn(delta)

func attackSelectorFunction(delta):
	if attack == 0:
		attack = randi_range(1,10)
	if attack % 2:
		uniqueAttack(delta)
	else:
		basicAttack(delta)

func uniqueAttack(delta: float):
	var rotationVelocity : float = 5.0
	var mult : int = -1
	player_direction.look_at(GlobalReferences.player_controller_position)
	var newRotation = player_direction.rotation.y + PI
	if position.z < 15 && rounds ==0:
		rounds+=1
	if position.z > 15 && rounds ==1:
		rounds+=1
	if position.z < 2.3 && rounds == 2:
		rounds+=1
	if position.z > 2.5 && rounds == 3:
		rounds+=1

	match rounds:
		0:
			newRotation = player_direction.rotation.y + PI
		1:
			newRotation = mult*(player_direction.rotation.y + PI/2)
			rotationVelocity = 15
		2:
			newRotation = player_direction.rotation.y + PI
		4:
			rotationVelocity = 0

	model.rotation.y = lerp_angle(model.rotation.y, newRotation, rotationVelocity * delta)
	var direction = model.basis.z.normalized()
	position += direction * 40 * delta
	if position.z < -10:
		rounds = 0
		visible = false
		pathFollow.progress_ratio = 0
		state = States.AlienStates.IDLE
		endAttack()
	if position.z > 45:
		rounds = 0
		model.rotation.y = PI
		pathFollow.progress_ratio = 0
		position = targetPosition + Vector3(0,0,20)
		await get_tree().create_timer(1).timeout
		state = States.AlienStates.RESPAWN
