extends CharacterBody3D

var bulletVelocity : float = 50.0
@onready var animatable_body_3d: AnimatableBody3D = $AnimatableBody3D

func _process(delta: float) -> void:
	if position.z > 45 || position.z < -5: 
		queue_free()
	position.z += bulletVelocity * delta
