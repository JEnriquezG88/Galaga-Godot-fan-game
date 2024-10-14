extends MeshInstance3D

var rotationVelocity : float = 10.0
var rotationTarget : float = 0.8

func _process(delta: float) -> void:
	rotation.z = lerp_angle(rotation.z, rotationTarget * GlobalInput.leftAxis.x, rotationVelocity * delta)
