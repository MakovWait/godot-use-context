extends GdUnitTestSuite

const Context = preload("res://addons/use-context/context.gd")
const ContextKeys = preload("res://addons/use-context/context_keys.gd")


func test_by_type():
	var ctx = Context.new()
	
	ctx.add("/", A.new())
	ctx.add("/", B.new())
	
	var result = ctx.find("/", ContextKeys.by_type(A))
	assert_object(result).is_instanceof(A)
	assert_object(result).is_not_instanceof(B)
	
	result = ctx.find("/", ContextKeys.by_type(B))
	assert_object(result).is_instanceof(B)
	assert_object(result).is_not_instanceof(A)


func test_by_type_inheritance():
	var ctx = Context.new()
	
	ctx.add("/", Child.new())
	
	var result = ctx.find("/", ContextKeys.by_type(Parent))
	assert_object(result).is_instanceof(Child)


func test_by_type_anonymous():
	var type = preload("res://tests/anonymous_type.gd")
	var ctx = Context.new()
	
	ctx.add("/", type.new())
	
	var result = ctx.find("/", ContextKeys.by_type(type))
	assert_object(result).is_instanceof(type)


class A:
	pass


class B:
	pass


class Parent:
	pass


class Child extends Parent:
	pass
