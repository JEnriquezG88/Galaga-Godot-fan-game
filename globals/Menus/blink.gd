extends Label

var tree : bool = false
func _ready() -> void:
	visible = false
func _process(delta: float) -> void:
	if get_tree() && !tree:
		tree = true
		blink()

func blink() -> void:
	var awaitTime : float = 0.5
	if visible:
		visible = false
	else:
		visible = true
	await get_tree().create_timer(awaitTime).timeout
	blink()
