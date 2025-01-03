@tool
class_name Card extends Node2D

signal mouse_entered(card: Card)
signal mouse_exited(card: Card)

@export var card_name: String = "Card Name"
@export var card_description: String = "Description"
@export var card_cost: int = 1
@export var card_image: Sprite2D

@onready var cost_lbl: Label = $costDisplay/costLbl
@onready var name_lbl: Label = $cardName/nameLbl
@onready var description_lbl: Label = $descriptionLbl
@onready var base_sprite: Sprite2D = $BaseCardTemplate

func _ready():
	set_card_values(card_cost, card_name, card_description)

func set_card_values(_cost: int, _name: String, _description: String):
	card_name = _name
	card_description = _description
	card_cost = _cost
	
	_update_graphics()
	
func _update_graphics():
	if cost_lbl.get_text() != str(card_cost):
		cost_lbl.set_text(str(card_cost))
	if name_lbl.get_text() != card_name:
		name_lbl.set_text(card_name.to_lower())
	if description_lbl.get_text() != card_description:
		description_lbl.set_text(card_description.to_lower())
		
func highlight():
	base_sprite.texture = load("res://sprites/cardtemplate_hover.png")
	
func unhighlight():
	base_sprite.texture = load("res://sprites/cardtemplate.png")
	
func activate():
	pass
	
func _process(delta):
	_update_graphics()
  
func _on_area_2d_mouse_entered():
	mouse_entered.emit(self)

func _on_area_2d_mouse_exited():
	mouse_exited.emit(self)

func _on_area_2d_input_event(viewport, event, shape_idx):
	pass # Replace with function body.
