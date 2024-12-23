class_name DeckViewWindow extends ScrollContainer

@onready var card_container_scn: PackedScene = preload("res://scenes/ui/CardContainer.tscn")

@onready var flow_container = $HFlowContainer

var cached_card_containers: Array[CardContainer] = []

func clear_display():
	for child in flow_container.get_children():
		child.remove_child(child.card)
		flow_container.remove_child(child)

func display_card_list(cardlist: Array[CardWithID]):
	clear_display()
	while cached_card_containers.size() < cardlist.size():
		cached_card_containers.push_back(card_container_scn.instantiate() as CardContainer)

	for i in cardlist.size():
		var cardWithId: CardWithID = cardlist[i] as CardWithID
		var card_container: CardContainer = cached_card_containers[i]
		card_container.card = cardWithId.card
		flow_container.add_child(card_container)
		card_container.card.scale = Vector2(.75,.75)
