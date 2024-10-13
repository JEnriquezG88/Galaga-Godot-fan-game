extends Node3D
class_name alien

var id : int
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
	if pathFollow.progress_ratio <= 1: pathFollow.progress_ratio += delta
	position = pathFollow.position
	rotation = pathFollow.rotation

func initPath(pathSource) -> void:
	path = Path3D.new()
	path.curve = load("res://enemies/generalPaths/down_right_init.tres")
	pathFollow = PathFollow3D.new()
	pathFollow.loop = false
	add_child(path)
	path.add_child(pathFollow)
