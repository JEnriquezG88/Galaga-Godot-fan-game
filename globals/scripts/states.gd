extends Node

enum AlienStates {
	IDLE,
	INITIALIZE,
	MOVE_TO_TARGET,
	ALIVE,
	CAPTURE,
	CAPTURING,
	ATTACK,
	DEAD,
	RESPAWN,
	TOTAL_DEAD
}
enum PlayerStates{
	IDLE,
	ON_NEW_SHIP,
	PLAYING,
	CAPTURE,
	DEAD
}
