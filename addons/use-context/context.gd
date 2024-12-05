var _dict = {}
var _result_factory_instance := FindResultFactory.new()


func add(path: String, ctx_value: Variant):
	assert(path.begins_with("/"))
	if not path in _dict:
		_dict[path] = []
	var bucket = _dict[path] as Array
	bucket.append(ctx_value)


func erase(path: String, ctx_value):
	if has(path):
		var bucket = get(path)
		var idx = bucket.find(ctx_value)
		if idx >= 0:
			bucket.remove_at(idx)


func _get(property):
	if has(property):
		return _dict[property]


func has(path: String):
	return path in _dict


func sanitize():
	for key in _dict.keys():
		if len(_dict[key]) == 0:
			_dict.erase(key)


func find(path_from: String, key: Callable):
	assert(path_from.begins_with("/"))
	while true:
		if has(path_from):
			var bucket = get(path_from)
			var opt = key.call(bucket, _result_factory_instance) as FindResult
			if opt.has_value():
				return opt.value()
		if path_from == "/":
			break
		path_from = path_from.get_base_dir()
	return null


class FindResultFactory:
	static func found(value: Variant) -> FindResult:
		return FindResult.new(true, value)
	
	static func not_found() -> FindResult:
		return FindResult.new(false)


class FindResult:
	var _has_value
	var _value
	
	func _init(has_value, value=null):
		_has_value = has_value
		_value = value
	
	func has_value():
		return _has_value
	
	func value():
		return _value
