@tool
extends Control
class_name UITargetingPrompt

@onready var accept_btn: Button = $AcceptBtn
@onready var start: Marker2D = $Start
@onready var end: Marker2D = $End
@onready var line_2d: Line2D = $Line2D

@export var source:Card
@export var target:Card
@export_tool_button("Test") var callable:Callable = test

var state:State
const TARGETING_PROMPT_UI = preload("uid://b3rvn7lxnc7q")

signal finished

enum State{
	NULL, SELECTION, HOVERING
}

static func create(src:Card) -> UITargetingPrompt:
	var prompt:UITargetingPrompt = TARGETING_PROMPT_UI.instantiate()
	prompt.source = src
	return prompt

func _ready() -> void:
	if Engine.is_editor_hint():
		#accept_btn.visible = true
		pass
	visible = true
	line_2d.visible = false
	CardEventBus.card_entered.connect(focus_card)
	CardEventBus.card_exited.connect(blur_card)

func _process(delta: float) -> void:
	pass

func focus_card(card:Card):
	if card != source:
		target = card
	calc_and_draw_path()

func blur_card(card:Card):
	target = null
	calc_and_draw_path()


func calc_and_draw_path():
	line_2d.clear_points()
	line_2d.visible = false
	if !target: return
	start.global_position = source.global_position
	end.global_position = target.global_position
	
	line_2d.add_point(start.global_position)
	line_2d.add_point(end.global_position)
	line_2d.visible = true
	
func test():
	calc_and_draw_path()
