extends Control

@onready var press_start: CenterContainer = $PressStart
@onready var score: MarginContainer = $Score
var gameStart : bool = false
signal startGame
signal newLevel
@onready var sound: AudioStreamPlayer2D = $sound
@onready var centerText: Label = $PressStart/VBoxContainer/PressStart
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

var capturedUI : bool = false

func _ready() -> void:
	centerText.text = "PUSH START BUTTON"
	press_start.visible = true
	score.visible = false
	grid_container.visible = true
	grid_container_2.visible = true
	captured_ui.visible = false
	on_new_level.visible = false
	recovered_ui.visible = false
	new_live.visible = false

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("start") && !gameStart:
		gameStart = true
		press_start.visible = false
		score.visible = true
		grid_container.visible = false
		grid_container_2.visible = false
		sound.play()
		startGame.emit()

func _on_player_dead_event() -> void:
	centerText.text = "Game Over"
	press_start.visible = true
	score.visible = false


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
	print("NEW LEVEL")
	on_new_level.visible = true
	level_text.text = "Level "+str(Level.level)
	for i in range(20):
		var value : bool
		if i % 2:
			value = false
		else:
			value = true
		level_text.visible = value
		await get_tree().create_timer(0.215).timeout
	on_new_level.visible = false
	newLevel.emit()


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
