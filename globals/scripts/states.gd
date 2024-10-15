extends Node

enum AlienStates {
	IDLE,
	INITIALIZE,
	MOVE_TO_TARGET,
	ALIVE,
	ATTACK,
	DEAD,
	RESPAWN,
	TOTAL_DEAD
}
enum PlayerStates{
	IDLE,
	ON_NEW_SHIP,
	PLAYING,
	DEAD
}
