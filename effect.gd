extends RefCounted
class_name Effect

enum Type{
	NULL,
	DAMAGE,
	HEAL,
	DESTROY,
	DRAW,
	DISCARD,
	ETC
}

static var type_to_effect:Dictionary[Type, Callable] = {
	Type.DAMAGE: damage,
	Type.HEAL: damage,
	Type.DESTROY: damage,
	Type.DRAW: damage,
	Type.DISCARD: damage,
	Type.ETC: etc,
}

static func damage(_source:Card,_action:ActionData):
	pass

static func etc(source:Card,_action:ActionData):
	print(source.data.name)
	
