extends Node2D

signal card_activated(card: UsuableCard)

@export var deck: Deck
@export var debug_mode = true:
	set(value):
		if !is_node_ready():
			await ready

		debug_mode = value
		$DebugButtons.visible = debug_mode

@onready var card_scene_spell_coin: PackedScene = preload("res://scenes/cards/TrickCard_Coin.tscn")
@onready var card_scene_spell_bomb: PackedScene = preload("res://scenes/cards/TrickCard_Bomb.tscn")
@onready var card_scene_spell_shield: PackedScene = preload("res://scenes/cards/TrickCard_Shield.tscn")
@onready var card_scene_unit: PackedScene = preload("res://scenes/cards/ServantCard.tscn")

@onready var hand: Hand = $Hand

func _ready():
	pass
	
func _process(delta):
	pass

func reset():
	$Hand.empty_hand()
	
func add_card(card_with_id: CardWithID):
	$Hand.add_card(card_with_id.card)

func remove_card(card: Node2D):
	$Hand.remove_card_by_entity(card)

func _on_button_button_up():
	var spell_card_coin = card_scene_spell_coin.instantiate()
	deck.add_card(spell_card_coin)
	
func _on_button_2_button_up():
	var unit_card = card_scene_unit.instantiate()
	deck.add_card(unit_card)

func _on_button_3_button_up():
	var spell_card_bomb = card_scene_spell_bomb.instantiate()
	deck.add_card(spell_card_bomb)

func _on_button_4_button_up() -> void:
	var spell_card_shield = card_scene_spell_shield.instantiate()
	deck.add_card(spell_card_shield)

func _on_hand_card_activated(card):
	card_activated.emit(card)

func _on_button_5_button_up() -> void:
	if deck.get_cards().is_empty():
		return
	var rndm_card: CardWithID = deck.get_cards().pick_random()
	deck.remove_card(rndm_card.id)
