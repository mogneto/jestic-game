@tool
class_name Character extends Node2D

@export var max_health: int = 20
@export var starting_gold: int = 1
@export var base_armor: int = 0
@export var current_gold_cap: int = 1

var health: int = 10
var gold: int = 1
var armor: int = 0

func set_health_values(_health: int, _max_health: int):
	max_health = _max_health
	health = _health
	
func update_health_bar():
	if ($HealthBar as ProgressBar).max_value != max_health:
		($HealthBar as ProgressBar).max_value = max_health
	if ($HealthBar as ProgressBar).value != health:
		($HealthBar as ProgressBar).value = health
		
func update_armor_icon(): # if (armor > 0) -> ArmorSprite.visible = true
	$"ArmorSprite".visible = armor > 0
	$"ArmorSprite/Label".set_text(str(armor))
	
func spend_gold(amount: int):
	gold -= amount

func take_damage(amount: int):
	var damage = max(amount - armor, 0)
	health -= damage
	armor = max(armor - amount,0)
	
func add_armor(amount: int):
	armor += amount

func start_turn():
	if current_gold_cap < 10:
		current_gold_cap += 1
	gold = current_gold_cap
	
func reset():
	health = max_health
	armor = base_armor
	gold = starting_gold

func _ready():
	reset()
	
func _process(delta):
	update_health_bar()
	update_armor_icon()
	pass
