extends Node

var level : int = 1
var targets : Array

func _init() -> void:
	generateTargets()

func generateTargets() -> void:
	var distribution: Array = DistributionGenerator.generate(level)
	for row in range(5):
		targets.append(TargetFactory.generateTargets(row, distribution[row]))
func newLevel() -> void:
	targets = []
	level += 1
	generateTargets()
