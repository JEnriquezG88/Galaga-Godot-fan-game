extends Node3D

var rotationVelocity : float = 10.0
var rotationTarget : float = 1
var canRotate : bool = false
@onready var spacechip: MeshInstance3D = $Spacechip
@onready var collision_shape_3d: CollisionShape3D = $CharacterBody3D/CollisionShape3D

func _ready() -> void:
	setCollision(true)

func _process(delta: float) -> void:
	if canRotate:
		spacechip.rotation.z = lerp_angle(spacechip.rotation.z, rotationTarget * GlobalInput.leftAxis.x, rotationVelocity * delta)
	else:
		spacechip.rotation.z = lerp_angle(spacechip.rotation.z, 0.0, rotationVelocity * delta)


func dead():
	var parent = get_parent_node_3d().get_parent_node_3d()
	parent.dead(true)
	queue_free()

func setCollision(value: bool):
	collision_shape_3d.disabled = value
