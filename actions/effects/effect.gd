extends RefCounted
class_name Effect

enum Type{
	NULL,
	DAMAGE,
	ATTACH,
	HEAL,
	DESTROY,
	DRAW,
	DISCARD,
	ETC
}

static var type_to_effect:Dictionary[Type, Callable] = {
	Type.DAMAGE: damage,
	Type.HEAL: heal,
	Type.DESTROY: destroy,
	Type.DRAW: draw,
	Type.DISCARD: discard,
	Type.ETC: etc,
}

static func damage(_source:Card,action:ActionData):
	var target = action.target_data.get_target()
	target.hp -= action.effect_ints[0]
static func etc(source:Card,_action:ActionData):
	print(source.data.name)
static func heal(_source:Card, _action:ActionData):
	print("Heal not implemented")
	
static func destroy(_source:Card, action:ActionData):
	print("Destroying!")
	for target in action.target_data.targets:
		target.die()
	
	
static func draw(_source:Card, _action:ActionData):
	print("Draw not implemented")
static func discard(_source:Card, _action:ActionData):
	print("Discard not implemented")
