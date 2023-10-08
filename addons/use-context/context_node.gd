extends Node

signal updated

const _Context = preload("res://addons/use-context/context.gd")
const _ContextKeys = preload("res://addons/use-context/context_keys.gd")

var _ctx = _Context.new()


func use(node: Node, key):
	var path_from = str(node.get_path()) 
	return _ctx.find(path_from, _cast_key(key))


func erase(path, ctx_value):
	if path is Node:
		path = str(path.get_path())
	else:
		path = str(path)
	_erase(path, ctx_value)


func add(path, ctx_value):
	if path is Node:
		path = str(path.get_path()) 
	else:
		path = str(path)
	_add(path, ctx_value)


func use_service(key):
	return _ctx.find("/", _cast_key(key))


func add_service(service):
	_add("/", service)


func erase_service(service):
	_erase("/", service)


func sanitize():
	_ctx.sanitize()


func _add(path, v):
	_ctx.add(path, v)
	updated.emit()


func _erase(path, v):
	_ctx.erase(path, v)
	updated.emit()


func _cast_key(key):
	if key is Script:
		return _ContextKeys.by_script(key)
	else:
		return key
