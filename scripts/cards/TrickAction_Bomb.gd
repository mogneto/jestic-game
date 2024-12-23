extends Node2D

func activate(game_state: Dictionary):
	#spend cost
	game_state.get("caster").spend_gold(1)
	#gain mana
	game_state.get("targets")[1].take_damage(1)
