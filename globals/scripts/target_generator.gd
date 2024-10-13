extends Node

func generateTargets(verticalPosition: float, rowDistribution: Array) -> Array:
	var targets : Array = []
	var firstTargetPosition : Vector3 = Vector3(-9, 0, 20)
	var iterations : int = 0
	for i in rowDistribution:
		var currentTargetPosition : Vector3 = Vector3(firstTargetPosition.x + 2 * iterations, firstTargetPosition.y, firstTargetPosition.z - verticalPosition * 2)
		if i == 1:
			targets.append(currentTargetPosition)
		iterations += 1
		pass
	iterations = 0
	return targets
