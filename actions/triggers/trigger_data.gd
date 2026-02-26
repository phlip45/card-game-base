extends Resource
class_name TriggerData

var targets:Array[Card]
@export var type:Type

enum Type{
	NULL,
	PLAY,
	TURN_START,
	TURN_END,
	DESTROY,
	DAMAGE,
	HEAL
}
