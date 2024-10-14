extends Node

var leftAxis : Vector2 = Vector2.ZERO

func _process(delta: float) -> void:
	leftAxis = Input.get_vector("Left", "Right", "Up", "Down")
