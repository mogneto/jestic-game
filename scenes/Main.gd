extends Node2D

@export var player_character: Character
@export var debug_mode: bool = true:
	set(value):
		if !is_node_ready():
			await ready

		debug_mode = value
		$dmg1.visible = debug_mode
		$dmg3.visible = debug_mode
	
@onready var game_control: GameController = $GameController
@onready var deck_view_overlay: DeckViewWindow = $CanvasLayer/DeckViewWindow as DeckViewWindow
@onready var deck_ui: PlayableDeckUI = $PlayableDeckUi
@onready var deck_n_hand = $DeckNHand

var enemy_character_state: int = 0

@onready var deck: Deck = Deck.new()

func restart_game():
	game_control.current_state = GameController.GameState.PLAYER_TURN
	$GameScreen/PlayerCharacter.reset()
	$GameScreen/EnemyCharacter.reset()
	deck_n_hand.reset()
	
func _ready():
	deck_n_hand.deck = deck

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	if !game_control.is_game_running:
		return
	$GoldPool.set_text(str($GameScreen/PlayerCharacter.gold))
	
	$CanvasLayer/VictoryOverlay.visible = false
	$CanvasLayer/GameOverOverlay.visible = false
	
	if $GameScreen/PlayerCharacter.health <= 0:
		game_control.transition(GameController.GameState.GAME_OVER)
	elif $GameScreen/EnemyCharacter.health <= 0:
		game_control.transition(GameController.GameState.VICTORY)
	
	match game_control.current_state:
		GameController.GameState.ENEMY_TURN:
			#ai logic
			match enemy_character_state:
				0:
					$GameScreen/EnemyCharacter.add_armor(0)
					$GameScreen/PlayerCharacter.take_damage(3)
					pass
				1:
					$GameScreen/EnemyCharacter.add_armor(1)
					$GameScreen/PlayerCharacter.take_damage(2)
					pass
				2:
					$GameScreen/EnemyCharacter.add_armor(2)
					$GameScreen/PlayerCharacter.take_damage(1)
					pass
					
			enemy_character_state = posmod (enemy_character_state + 1, 3)
			game_control.transition(GameController.GameState.PLAYER_TURN)
			$GameScreen/PlayerCharacter.start_turn()
			
		GameController.GameState.VICTORY:
			$CanvasLayer/VictoryOverlay.visible = true
			
		GameController.GameState.GAME_OVER:
			$CanvasLayer/GameOverOverlay.visible = true

func _input(event):
	if event.is_action_pressed("restart"):
		restart_game()
		
func _on_deck_n_hand_card_activated(card: UsuableCard) -> void:
	var card_cost: int = card.get_cost()
	
	if card_cost <= $GameScreen/PlayerCharacter.gold:
		card.activate({
			"caster": $GameScreen/PlayerCharacter,
			"targets": [$GameScreen/PlayerField, $GameScreen/EnemyCharacter]
			
		})
		deck_n_hand.remove_card(card)
		card.queue_free()
	else:
		pass

func _on_dmg_1_button_up() -> void:
	player_character.take_damage(1)
	pass
	
func _on_dmg_3_button_up() -> void:
	player_character.take_damage(3)
	pass

func _on_end_turn_button_up() -> void:
	if game_control.current_state == GameController.GameState.PLAYER_TURN:
		game_control.transition(GameController.GameState.ENEMY_TURN)
		$GameScreen/EnemyCharacter.start_turn()


func _on_deck_button_button_up() -> void:
	#if $CanvasLayer/DeckViewWindow.cached_card_containers.is_empty():
		#pass
	if deck_view_overlay.visible == false:
		game_control.pause()
		deck_view_overlay.visible = true
		deck_view_overlay.display_card_list(deck.get_cards())
	else:
		deck_view_overlay.visible = false
		game_control.resume()

func _on_start_game_button_up() -> void:
	deck_ui.deck = deck.get_playable_deck()
	deck_ui.visible = true
	pass # Replace with function body.

func _on_playable_deck_ui_button_up() -> void:
	var card_with_id = deck_ui.draw()
	
	if card_with_id:
		deck_n_hand.add_card(card_with_id)
