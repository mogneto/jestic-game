class_name GameController extends Node2D

var is_game_running = true

enum GameState 
{
	PLAYER_TURN,
	ENEMY_TURN,
	GAME_OVER,
	VICTORY
}

@onready var current_state: GameState = GameState.PLAYER_TURN

func pause():
	is_game_running = false
	
func resume():
	is_game_running = true

func transition(next_state: GameState):

	match current_state:
		GameState.PLAYER_TURN:
			pass
		GameState.ENEMY_TURN:
			pass
		GameState.GAME_OVER:
			pass
		GameState.VICTORY:
			pass
			
	current_state = next_state
	
	match current_state:
		GameState.PLAYER_TURN:
			pass
		GameState.ENEMY_TURN:
			pass
		GameState.GAME_OVER:
			pass
		GameState.VICTORY:
			pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
