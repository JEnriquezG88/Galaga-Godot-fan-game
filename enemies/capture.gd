extends Node3D


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.get_collision_layer() & 1:
		var spaceshipParent = body.get_parent_node_3d()
		var spaceshipController = spaceshipParent.get_parent_node_3d().get_parent_node_3d()
		spaceshipController.states = States.PlayerStates.CAPTURE
		spaceshipController.setSpaceshipCollisions(false)
		var initialPosition : Vector3 = Vector3(0,0,-6)
		spaceshipParent.queue_free()
		var parent = get_parent_node_3d()
		parent.get_parent_node_3d().onCaptured(initialPosition)
