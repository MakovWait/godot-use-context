extends GdUnitTestSuite

const Context = preload("res://addons/use-context/context.gd")
const ContextKeys = preload("res://addons/use-context/context_keys.gd")


func test_by_type():
	var ctx = Context.new()
	
	ctx.add("/", A.new())
	ctx.add("/", B.new())
	
	var result = ctx.find("/", ContextKeys.by_script(A))
	assert_object(result).is_instanceof(A)
	assert_object(result).is_not_instanceof(B)
	
	result = ctx.find("/", ContextKeys.by_script(B))
	assert_object(result).is_instanceof(B)
	assert_object(result).is_not_instanceof(A)


class A:
	pass


class B:
	pass
