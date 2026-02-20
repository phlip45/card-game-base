extends Node2D
class_name Card

@onready var sprite_2d: Sprite2D = $Sprite2D
@export var data:CardData
@export var texture:Texture2D
@export var value:bool

var attached_actions:Dictionary[TriggerData.Type, ActionContainer] = {
	TriggerData.Type.PLAY: null,
	TriggerData.Type.TURN_START: null,
	TriggerData.Type.DAMAGE: null,
	TriggerData.Type.DESTROY: null,
	TriggerData.Type.HEAL: null,
	TriggerData.Type.TURN_END: null,
}

@warning_ignore_start("unused_signal")
signal played
signal turn_started
signal destroyed
signal damaged
signal healed
signal turn_ended
@warning_ignore_restore("unused_signal")

signal clicked

func _ready() -> void:
	if !texture: 
		push_error("Missing Texture in Card")
	sprite_2d.texture = texture
	for action:ActionData in data.actions:
		handle_action_setup(action)

func play()-> void:
	played.emit()

func attach_action(action:ActionData):
	var container:ActionContainer = attached_actions[action.trigger.type]
	if !container:
		container = ActionContainer.new()
		attached_actions.set(action.trigger.type, container)
	container.actions.append(action)
	var callable:Callable = stack.add.bind(self,action)
	match action.trigger.type:
		TriggerData.Type.PLAY:
			played.connect(callable)
		TriggerData.Type.TURN_START:
			turn_started.connect(callable)
		TriggerData.Type.TURN_END:
			turn_ended.connect(callable)
		TriggerData.Type.DESTROY:
			destroyed.connect(callable)
		TriggerData.Type.DAMAGE:
			damaged.connect(callable)
		TriggerData.Type.HEAL:
			healed.connect(callable)

func die():
	var tween:Tween = create_tween()
	tween.tween_property(self, "position", Vector2(position.x, -100), 1)
	tween.tween_property(self, "position", Vector2(position.x, 1280), 2)
	tween.tween_callback(queue_free)

func _on_button_pressed() -> void:
	clicked.emit()
	print("Click!")

func handle_action_setup(action:ActionData):
	attach_action(action)


func _on_button_mouse_entered() -> void:
	CardEventBus.on_card_entered(self)


func _on_button_mouse_exited() -> void:
	CardEventBus.on_card_exited(self)
