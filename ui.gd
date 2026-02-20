extends CanvasLayer
class_name UI

@export var crosshair: Control
@export var main: Node2D
@export var current_action: RichTextLabel
var last_card_clicked:Card
var state:State = State.SELECTING_CARD


enum State{
	NULL,
	AWAITING_STACK,
	SELECTING_CARD,
	TARGETING_SINGLE,
	TARGETING_MULTIPLE,
}


func _ready() -> void:
	stack.ui = self
	current_action.text = State.find_key(state)

func _process(_delta: float) -> void:
	crosshair.global_position = main.get_global_mouse_position()
	if state == State.TARGETING_SINGLE:
		pass

func select_card(card_selected:Card):
	if state == State.SELECTING_CARD:
		change_state(State.AWAITING_STACK)
		last_card_clicked = card_selected
		card_selected.play()
		await stack.resolve()
		change_state(State.SELECTING_CARD)

func change_state(_state:State):
	state = _state
	match state:
		State.NULL:
			pass
		State.SELECTING_CARD:
			current_action.text = "Select a card"
		State.TARGETING_SINGLE:
			current_action.text = "Target a card"
		State.TARGETING_MULTIPLE:
			current_action.text = "Target {X} Cards"
		State.AWAITING_STACK:
			current_action.text = "Awaiting stack"

func target_single_card(source:Card, target_data:TargetData) -> Card:
	var prompt:UITargetingPrompt = UITargetingPrompt.create(source)
	add_child(prompt)
	var target:Card = await prompt.finished
	if !target:
		print()
	return target
