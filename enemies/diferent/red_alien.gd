extends alien

func _process(delta: float) -> void:
	match state:
		States.AlienStates.INITIALIZE:
			initialize()
		States.AlienStates.MOVE_TO_TARGET:
			moveToTarget(delta)
		States.AlienStates.ATTACK:
			basicAttack(delta)
		States.AlienStates.RESPAWN:
			respawn(delta)
