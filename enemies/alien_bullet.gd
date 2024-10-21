extends CharacterBody3D

var bulletVelocity : float = 80.0

func _process(delta: float) -> void:
	if position.z > 45 || position.z < -5: 
		queue_free()
	var rotation = basis.z.normalized()
	position += bulletVelocity * rotation * delta
