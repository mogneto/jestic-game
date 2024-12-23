extends Node2D

func activate(game_state: Dictionary):
	
	#spend cost
	game_state.get("caster").spend_gold(2)
	#gain mana
	game_state.get("targets")[0].add_card(self.get_parent())
	print_debug(game_state.get("targets")[0].field)
	pass
