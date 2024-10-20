extends Node3D

@onready var particles: GPUParticles3D = $Particles

func _init() -> void:
	print("hola")
	particles.emitting = true
	await get_tree().create_timer(1).timeout
	queue_free()
