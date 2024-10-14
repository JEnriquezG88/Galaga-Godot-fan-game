extends Node3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var canFly : bool = false

func _ready() -> void:
	var time = randf_range(0.1, 2.0)
	await get_tree().create_timer(time).timeout
	animation_player.play("Fly")
