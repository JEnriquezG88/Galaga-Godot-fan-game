extends PathFollow3D

@export var animation_vel : float = 0.5

func _ready() -> void:
	progress_ratio = 0

func _process(delta: float) -> void:
	await get_tree().create_timer(1.0).timeout
	if progress_ratio <= 1:
		progress_ratio += animation_vel*delta
