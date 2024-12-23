class_name PlayableDeck extends Resource

var cards: Array[CardWithID] = []

# draw one card from the top of the deck
func draw_card() -> CardWithID:
	return cards.pop_back()

# shuffle the order of cards in the deck
func shuffle():
	cards.shuffle()

# look at the top card of the deck
func peek_top() -> CardWithID:
	return cards.back()

# receives a card as argument, then puts it on top of the deck
func put_card_on_top(card: CardWithID):
	cards.push_back(card)
