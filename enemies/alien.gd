extends Node3D
class_name alien

var id : int
var targetPosition : Vector3 = Vector3.ZERO
var xOffsetTentative : float = 0.0
var xOffset : float = 0.0
var zOffsetTentative : float = 0.0
var zOffset : float = 0.0
var state = States.AlienStates.IDLE

var path : Path3D
var pathFollow : PathFollow3D

func _ready() -> void:
	visible = false


func _process(delta: float) -> void:
	match state:
		States.AlienStates.INITIALIZE:
			initialize()
		States.AlienStates.MOVE_TO_TARGET:
			moveToTarget(delta)

func initialize():
	position = pathFollow.position

func moveToTarget(delta: float):
	if !visible : visible = true
	if pathFollow.progress_ratio <= 1: pathFollow.progress_ratio += delta / 2
	var newPos
	if targetPosition.x < 0:
		newPos = Vector3(pathFollow.position.x + xOffset, pathFollow.position.y, pathFollow.position.z + zOffset)
	else:
		newPos = Vector3(pathFollow.position.x + xOffset, pathFollow.position.y, pathFollow.position.z + zOffset)
	position = lerp(position, newPos, 15 * delta)
	rotation = pathFollow.rotation
	
	if pathFollow.progress_ratio > 0.7:
		xOffset = lerp(xOffset, xOffsetTentative, 5 * delta)
		zOffset = lerp(zOffset, zOffsetTentative, 5 * delta)

func initPath(pathSource) -> void:
	path = Path3D.new()
	path.curve = load(pathSource)
	pathFollow = PathFollow3D.new()
	pathFollow.loop = false
	add_child(path)
	path.add_child(pathFollow)
