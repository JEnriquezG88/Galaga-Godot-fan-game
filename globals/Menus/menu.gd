extends Control

@onready var press_start: CenterContainer = $PressStart
@onready var score: MarginContainer = $Score
var gameStart : bool = false
signal startGame
signal newLevel
@onready var sound: AudioStreamPlayer2D = $sound
@onready var centerText: Label = $PressStart/VBoxContainer/MarginContainer/PressStart
@onready var grid_container: GridContainer = $GridContainer
@onready var grid_container_2: GridContainer = $GridContainer2
@onready var captured_ui: CenterContainer = $CapturedUI
@onready var fighter_captured: Label = $CapturedUI/VBoxContainer/FighterCaptured
@onready var on_new_level: CenterContainer = $OnNewLevel
@onready var level_text: Label = $OnNewLevel/VBoxContainer/LevelText
@onready var recovered_ui: CenterContainer = $RecoveredUI
@onready var fighter_recovered: Label = $RecoveredUI/VBoxContainer/FighterRecovered
@onready var new_live: CenterContainer = $NewLive
@onready var extralife: Label = $NewLive/VBoxContainer/Extralife
@onready var final_score: Label = $GameOver/MarginContainer/VBoxContainer/HBoxContainer/FinalScore
@onready var level_number: Label = $GameOver/MarginContainer/VBoxContainer/Level/LevelNumber
@onready var game_over: CenterContainer = $GameOver
@onready var pause_menu: CenterContainer = $PauseMenu
@onready var spash: CenterContainer = $Spash
@onready var texture_rect: TextureRect = $Spash/TextureRect
@onready var color_rect: ColorRect = $Spash/ColorRect
var canInit : bool = false
var capturedUI : bool = false
var spashInt : int = 0

func _ready() -> void:
	spash.visible = true
	texture_rect.modulate.a = 0.0
	spashInt = 1
	centerText.text = "PUSH START BUTTON"
	#true
	press_start.visible = true
	grid_container.visible = true
	grid_container_2.visible = true
	#false
	score.visible = false
	captured_ui.visible = false
	on_new_level.visible = false
	recovered_ui.visible = false
	new_live.visible = false
	game_over.visible = false

func _process(delta: float) -> void:
	if spashInt == 1:
		texture_rect.modulate.a = lerp(texture_rect.modulate.a, 2.0, delta/2)
		if texture_rect.modulate.a > 1.5:
			spashInt = 2
	if spashInt == 2:
		texture_rect.modulate.a = lerp(texture_rect.modulate.a, 0.0, 2 * delta)
		if texture_rect.modulate.a < 0.01:
			spashInt = 3
	if spashInt == 3:
		color_rect.color.a = lerp(color_rect.color.a, 0.0, 2 * delta)
		if color_rect.color.a < 0.5:
			canInit = true
		if color_rect.color.a < 0.01:
			spashInt = 4
	if spashInt == 4:
		spash.visible = false
		spashInt = 0

func initGame():
	centerText.text = "PUSH START BUTTON"
	press_start.visible = true
	score.visible = false
	grid_container.visible = true
	grid_container_2.visible = true
	captured_ui.visible = false
	on_new_level.visible = false
	recovered_ui.visible = false
	new_live.visible = false
	game_over.visible = false

func _input(event: InputEvent) -> void:
	if Input.is_action_just_released("start") && !gameStart && canInit:
		gameStart = true
		press_start.visible = false
		score.visible = true
		grid_container.visible = false
		grid_container_2.visible = false
		_on_alien_handler_new_level()
	if Input.is_action_just_pressed("Pause") && gameStart && Level.state != States.LevelStates.GAME_OVER:
		get_tree().paused = !get_tree().paused
		pause_menu.visible = get_tree().paused
		score.visible = !get_tree().paused
		

func _on_player_dead_event() -> void:
	Level.state = States.LevelStates.GAME_OVER
	sound.stream = preload("res://globals/effects/GameOver.mp3")
	sound.play()
	final_score.text = " "+str(Level.score)
	level_number.text = " 0"+str(Level.level)
	game_over.visible = true
	score.visible = false
	captured_ui.visible = false
	on_new_level.visible = false
	recovered_ui.visible = false
	new_live.visible = false

func _on_alien_handler_captured_ui() -> void:
	captured_ui.visible = true
	Level.score-=100
	for i in range(10):
		var value : bool
		if i % 2:
			value = false
		else:
			value = true
		fighter_captured.visible = value
		await get_tree().create_timer(0.43).timeout

func _on_alien_handler_new_level() -> void:
	on_new_level.visible = true
	level_text.text = "Level "+str(Level.level)
	for i in range(20):
		if i == 1:
			sound.stream = preload("res://globals/effects/NewLevel.mp3")
			sound.play()
		if i == 10:
			if Level.level == 1 || Level.level == 88:
				sound.stream = preload("res://globals/effects/StartGame.mp3")
				sound.play()
				Level.state = States.LevelStates.PLAYING
				startGame.emit()
			else:
				newLevel.emit()
		var value : bool
		if i % 2:
			value = false
		else:
			value = true
		if i < 10:
			level_text.visible = value
		else:
			level_text.visible = false
		await get_tree().create_timer(0.2).timeout
	on_new_level.visible = false

func _on_alien_handler_add_spaceship() -> void:
	recovered_ui.visible = true
	Level.score+=150
	for i in range(10):
		var value : bool
		if i % 2:
			value = false
		else:
			value = true
		fighter_recovered.visible = value
		await get_tree().create_timer(0.43).timeout

func _on_player_add_live() -> void:
	new_live.visible = true
	Level.score+=150
	for i in range(10):
		var value : bool
		if i % 2:
			value = false
		else:
			value = true
		extralife.visible = value
		await get_tree().create_timer(0.43).timeout
