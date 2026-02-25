extends Resource
class_name ActionData

@export var name:String
@export var trigger:TriggerData
@export var effect:EffectData
@export var target_data:TargetData
@export var effect_ints:Array[int]
@export var effect_strings:Array[String]
@export var effect_action_datas:Array[ActionData]

func get_targets():
	pass
