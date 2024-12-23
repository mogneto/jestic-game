@tool
class_name Field extends Node2D

signal card_activated(card: UsuableCard)

@export var field_length = Vector2(2020,500)

@onready var collision_shape: CollisionShape2D = $debugShape

var field: Array = []
var touched: Array = []
var current_selected_card_index: int = -1

func add_card(card: Node2D):
	field.push_back(card)
	add_child(card)
	card.mouse_entered.connect(_handle_card_touched)
	card.mouse_exited.connect(_handle_card_untouched)
	reposition_cards()

func remove_card(index: int) -> Node2D:
	var removing_card = field[index]
	field.remove_at(index)
	touched.remove_at(touched.find(removing_card))
	remove_child(removing_card)
	reposition_cards()
	return removing_card

func remove_card_by_entity(card: Node2D):
	var remove_index = field.find(card)
	remove_card(remove_index)

func reposition_cards():
	for card in field:
		_update_card_transform(card, field.find(card))
		pass

func get_card_position(index: int) -> Vector2:
	var x: float = collision_shape.position.x + ((index) * 80) - ((field.size()-1) * 40)
	var y: float = collision_shape.position.y
	
	return Vector2(int(x), int(y))

func _update_card_transform(card: Node2D, index: int):
	var scale = Vector2(0.5,0.5)
	card.set_position(get_card_position(index))
	card.set_scale(scale)

func _handle_card_touched(card):
	touched.push_back(card)

func _handle_card_untouched(card: Node2D):
	touched.remove_at(touched.find(card))

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("mouse_click") && current_selected_card_index >= 0:
		var card = field[current_selected_card_index]
		card_activated.emit(card)
		current_selected_card_index = -1

func _process(delta):
	for card in field:
		current_selected_card_index = -1

	if !touched.is_empty():
		var touched_index: int = -1
		
		if touched_index >= 0 && touched_index < field.size():
			field[touched_index].highlight()
			current_selected_card_index = touched_index

#tool logic
	if (collision_shape.shape as RectangleShape2D).size != field_length:
		(collision_shape.shape as RectangleShape2D).set_size(field_length)
	#print_debug((collision_shape.shape as RectangleShape2D).size)
