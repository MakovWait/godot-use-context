extends GdUnitTestSuite

var NodeContext = preload("res://addons/use-context/context_node.gd")


func test_context_node_scene():
	var scene = scene_runner("res://tests/test_ctx_node_scene.tscn")

##root
##├── a
##├── b
##│   └ c

	var root = scene.scene()
	var a = scene.find_child("a")
	var b = scene.find_child("b")
	var c = scene.find_child("c")
	
	# autoload
	var ctx = Context
	
	ctx.add(root, CtxValue.new("root_ctx"))
	var b_ctx = CtxValue.new("b_ctx_override")
	ctx.add(b, b_ctx)
	
	var result = ctx.use(a, CtxValue)
	assert_str(result.value).is_equal("root_ctx")
	
	result = ctx.use(c, CtxValue)
	assert_str(result.value).is_equal("b_ctx_override")
	
	ctx.erase(b, b_ctx)
	result = ctx.use(c, CtxValue)
	assert_str(result.value).is_equal("root_ctx")


class CtxValue:
	var value
	func _init(v):
		value = v
