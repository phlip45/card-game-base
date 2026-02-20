extends Node2D

@export var cards:Array[Card]
@export var ui: CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for card in cards:
		card.clicked.connect(select_card.bind(card))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func select_card(card:Card):
	ui.select_card(card)
