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

static func single(source:Card, action_data:ActionData) -> Array[Variant]:
	if action_data.target_data.target_type == Type.CARD:
		var target = await stack.ui.target_single_card(source, action_data)
		if target:
			return [target]
	return []
