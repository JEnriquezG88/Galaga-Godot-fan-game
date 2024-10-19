extends Control

@onready var press_start: CenterContainer = $PressStart
@onready var score: MarginContainer = $Score
var gameStart : bool = false
signal startGame
@onready var sound: AudioStreamPlayer2D = $sound
@onready var centerText: Label = $PressStart/PressStart

func _ready() -> void:
	press_start.visible = true
	score.visible = false

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("start") && !gameStart:
		gameStart = true
		press_start.visible = false
		score.visible = true
		sound.play()
		startGame.emit()


func _on_player_dead_event() -> void:
	centerText.text = "Game Over"
	press_start.visible = true
	score.visible = false
