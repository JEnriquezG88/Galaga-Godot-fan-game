extends Node

var level : int = 1
var targets : Array
var score : int = 0
var liveScore = 20000
var hiScore : int = 3000
var gameOver : bool = false
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
