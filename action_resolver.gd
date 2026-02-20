extends Node
class_name Stack

var ui:UI
var _stack:Array[Packet]
var resolution_count:int = 0
var infinite_limit:int = 100

signal finished

func add(source:Card, action:ActionData):
	var packet:Packet = Packet.create(source,action)
	_stack.append(packet)

func resolve():
	var packet:Packet = _stack.pop_back()
	if !packet: 
		_stack.clear()
		finish_resolving_stack()
		return
	# Do the last thing in the stack
	await resolve_packet(packet)
	resolution_count += 1
	if resolution_count > infinite_limit:
		_stack.clear()
		finish_resolving_stack()
		return
	resolve()

func finish_resolving_stack():
	resolution_count = 0
	finished.emit()

func resolve_packet(packet:Packet):
	# check if the effect targets anything
	if packet.action.target:
		#var targets:Array[Card] = packet.action.target.
		await ui.target_single_card(packet.source,packet.action.target)
		pass
	Effect.type_to_effect[packet.action.effect.type].call(packet.source,packet.action)



class Packet:
	var source:Card
	var action:ActionData
	
	static func create(src:Card, act:ActionData) -> Packet:
		var packet:Packet = Packet.new()
		packet.source = src
		packet.action = act
		return packet
