extends Node

func generate(distNumber : int) -> Array:
	var distribution : Array = distSelect(distNumber)
	return distribution

func distSelect(dist: int) -> Array:
	match dist:
		1:
			return firstDist()
		2:
			return secondDist()
		3:
			return thirdDist()
		4:
			return fourthDist()
		5:
			return fifthDist()
		_:
			return firstDist()

func firstDist() -> Array:
	var dist : Array = []
	dist.append([0, 0, 0, 1, 1, 1, 1, 0, 0, 0])
	dist.append([0, 0, 1, 1, 1, 1, 1, 1, 0, 0])
	dist.append([0, 1, 1, 1, 1, 1, 1, 1, 1, 0])
	dist.append([1, 1, 1, 1, 1, 1, 1, 1, 1, 1])
	dist.append([1, 1, 1, 1, 1, 1, 1, 1, 1, 1])
	return dist
func secondDist() -> Array:
	var dist : Array = []
	dist.append([0, 0, 0, 0, 1, 1, 0, 0, 0, 0])
	dist.append([0, 0, 1, 0, 1, 1, 0, 1, 0, 0])
	dist.append([1, 1, 1, 1, 1, 1, 1, 1, 1, 1])
	dist.append([0, 1, 1, 1, 0, 0, 1, 1, 1, 0])
	dist.append([1, 1, 1, 1, 1, 1, 1, 1, 1, 1])
	return dist
func thirdDist() -> Array:
	var dist : Array = []
	dist.append([1, 0, 0, 1, 1, 1, 1, 0, 0, 1])
	dist.append([0, 1, 0, 1, 1, 1, 1, 0, 1, 0])
	dist.append([0, 0, 1, 1, 1, 1, 1, 1, 0, 0])
	dist.append([0, 1, 0, 1, 1, 1, 1, 0, 1, 0])
	dist.append([1, 0, 0, 0, 0, 0, 0, 0, 0, 1])
	return dist
func fourthDist() -> Array:
	var dist : Array = []
	for i in range(5):
		if i % 2:
			dist.append([0, 1, 0, 1, 0, 1, 0, 1, 0, 1])
		else:
			dist.append([1, 0, 1, 0, 1, 0, 1, 0, 1, 0])
	return dist
func fifthDist() -> Array:
	var dist : Array = []
	dist.append([0, 1, 1, 1, 0, 0, 1, 1, 1, 0])
	dist.append([1, 0, 1, 1, 0, 0, 1, 1, 0, 1])
	dist.append([1, 1, 0, 0, 1, 1, 0, 0, 1, 1])
	dist.append([1, 1, 1, 1, 0, 1, 1, 1, 1, 1])
	dist.append([1, 1, 1, 0, 1, 0, 1, 1, 1, 1])
	return dist
