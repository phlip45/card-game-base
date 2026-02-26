extends Node
class_name CardEvents

signal card_entered(card:Card)
signal card_exited(card:Card)

func on_card_entered(card:Card):
	card_entered.emit(card)
	
func on_card_exited(card:Card):
	card_exited.emit(card)
