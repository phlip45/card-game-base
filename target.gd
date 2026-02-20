extends RefCounted
class_name Target

enum Count{
	NULL, SINGLE, MULTI, ALL
}

enum Type{
	NULL, CARD, PLAYER
}

static var count_to_target:Dictionary[Count, Callable] = {
	Count.SINGLE: single,
	Count.MULTI: single,
	Count.ALL: single,
}

static func single(source:Card, target_data:TargetData) -> Array[Variant]:
	if target_data.target_type == Type.CARD:
		var target = await stack.ui.target_single_card(source, target_data)
		return [target]
	return []
