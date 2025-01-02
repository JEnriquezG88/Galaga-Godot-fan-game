extends Node3D
class_name alien

var id : int
var targetPosition : Vector3 = Vector3.ZERO
var xOffsetTentative : float = 2.0
var xOffset : float = 0.0
var zOffsetTentative : float = 0.0
var zOffset : float = 0.0
var state = States.AlienStates.IDLE
var mult : float = 6.0
var path : Path3D
var pathFollow : PathFollow3D
var playerControllerPosition : Vector3 = Vector3.ZERO
var lives : int = 5
var attack : int = 0
var endUniqueAttack : bool = false
var addLife : bool = false
var addSpaceship : bool = false
var captureSpaceship : bool = false
@onready var model: Node3D = $model
@onready var player_direction: Node3D = $playerDirection
@onready var area_3d: Area3D = $Area3D
@onready var collision_shape_3d: CollisionShape3D = $Area3D/CollisionShape3D
var shot : bool = false

func _ready() -> void:
	visible = false

func initialize():
	position = pathFollow.position
	xOffset = 0
	zOffset = 0

func moveToTarget(delta: float):
	if pathFollow.progress_ratio > 0.1:
		if !visible : visible = true
	if pathFollow.progress_ratio <= 1: pathFollow.progress_ratio += delta / 2
	var newPos
	if targetPosition.x < 0:
		newPos = Vector3(pathFollow.position.x + xOffset, pathFollow.position.y, pathFollow.position.z + zOffset)
	else:
		newPos = Vector3(pathFollow.position.x + xOffset, pathFollow.position.y, pathFollow.position.z + zOffset)
	position = lerp(position, newPos, 15 * delta)
	model.rotation = pathFollow.rotation
	
	if pathFollow.progress_ratio > 0.8:
		xOffset = lerp(xOffset, xOffsetTentative, mult * delta)
		zOffset = lerp(zOffset, zOffsetTentative, mult * delta)
	
	if abs(abs(position.x) - abs(targetPosition.x)) < 0.01 && abs(abs(position.z) - abs(targetPosition.z)) < 0.01:
		state = States.AlienStates.ALIVE

func initPath(pathSource) -> void:
	path = Path3D.new()
	path.curve = load(pathSource)
	pathFollow = PathFollow3D.new()
	pathFollow.loop = false
	pathFollow.use_model_front = true
	add_child(path)
	path.add_child(pathFollow)

func basicAttack(delta: float):
	var rotationVelocity : float
	if position.z > 8:
		rotationVelocity = 5
	elif position.z > 1:
		rotationVelocity = 1
	else:
		rotationVelocity = 0
	player_direction.look_at(GlobalReferences.player_controller_position)
	model.rotation.y = lerp_angle(model.rotation.y, player_direction.rotation.y + PI, rotationVelocity * delta)
	var direction = model.basis.z.normalized()
	position += direction * 40 * delta
	
	if position.z < 20 && position.z > 19.5:
		if !shot:
			shot = true
			var shotRand = randi_range(1,10)
			if shotRand % 2:
				shoot()

	if position.z < -10:
		visible = false
		pathFollow.progress_ratio = 0
		state = States.AlienStates.IDLE
		endAttack()

func shoot():
	var bullet = preload("res://enemies/bullet.tscn").instantiate()
	bullet.position = position
	bullet.rotation.y = player_direction.rotation.y + PI
	var parent = get_parent_node_3d().get_parent_node_3d()
	parent.add_child(bullet)

func endAttack():
	attack = 0
	state = States.AlienStates.INITIALIZE
	await get_tree().create_timer(3).timeout
	state = States.AlienStates.MOVE_TO_TARGET

func dead():
	#visible = false
	explosion()
	Level.score += 100
	var parent = get_parent_node_3d()
	parent.dead()
	position = targetPosition + Vector3(0,0,20)
	if lives > 0:
		model.rotation.y = PI
		var time = randi_range(0, 3)
		await get_tree().create_timer(time).timeout
		state = States.AlienStates.RESPAWN
		visible = true
		lives-=1
	else:
		state = States.AlienStates.TOTAL_DEAD
		get_parent_node_3d().deadAliens += 1

func explosion():
	var parent = get_parent_node_3d()
	var explosionEffect = preload("res://globals/effects/explosion.tscn").instantiate()
	explosionEffect.position = position
	parent.add_child(explosionEffect)

func respawn(delta):
	position = lerp(position, targetPosition, 10 * delta)
	if abs(targetPosition.z - position.z) < 0.01:
		model.rotation.y = lerp_angle(model.rotation.y, 2 * PI, 10*delta)
	if abs((2 * PI) - model.rotation.y) < 0.01:
		model.rotation.y = 0.0
		state = States.AlienStates.ALIVE

func _on_area_3d_body_entered(body: Node3D) -> void:
	if position.z < 38:
		if body.collision_layer & (1 << 1) != 0:
			if state == States.AlienStates.CAPTURE || state == States.AlienStates.CAPTURING:
				get_parent_node_3d().canAttack = true
				get_parent_node_3d().enemyAttack()
				get_parent_node_3d().canReplaceSound = true
			if addLife:
				addLife = false
				get_parent_node_3d().addLife.emit()
			if addSpaceship:
				addSpaceship = false
				get_parent_node_3d().addSpaceship.emit()
			body.queue_free()
		else:
			if addLife:
				addLife = false
			var colisionParent = body.get_parent_node_3d()
			colisionParent.dead()
		state = States.AlienStates.DEAD
		dead()
