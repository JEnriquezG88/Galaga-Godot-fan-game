extends Node3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _process(delta: float) -> void:
	var time = randi_range(1, 10)
	await get_tree().create_timer(time).timeout
	animation_player.play("Fly")
