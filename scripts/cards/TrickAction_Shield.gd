extends Node2D

func activate(game_state: Dictionary):
	var caster = game_state.get("caster")
	#spend cost
	caster.spend_gold(1)
	#gain mana
	caster.add_armor(1)
