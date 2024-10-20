extends Node3D
@onready var red_triangles: GPUParticles3D = $RedTriangles
@onready var red_rentagles: GPUParticles3D = $RedRentagles
@onready var white: GPUParticles3D = $White
@onready var blue: GPUParticles3D = $Blue

func _ready() -> void:
	red_triangles.emitting = true
	red_rentagles.emitting = true
	white.emitting = true
	blue.emitting = true
	await get_tree().create_timer(1).timeout
	queue_free()
