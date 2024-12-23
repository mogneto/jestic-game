class_name CardContainer extends Container

const CARD_COMPONENT_POSITION: Vector2 = Vector2(60,96)

var card: UsuableCard:
	set(_card):
		card = _card
		card.set_position(CARD_COMPONENT_POSITION)
		add_child(card)
