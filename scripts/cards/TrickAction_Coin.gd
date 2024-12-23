extends Node2D

func activate(game_state: Dictionary):
	var caster = game_state.get("caster")
	#spend cost
	caster.gold += 1
