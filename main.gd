extends Node2D

@export var cards:Array[Card]
@export var ui: CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in 5:
		var card = Card.create()
		card.position = Vector2(randi_range(0,1280),randi_range(0,720))
		add_child(card)


func select_card(card:Card):
	ui.select_card(card)
