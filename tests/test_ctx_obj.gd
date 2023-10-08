extends GdUnitTestSuite

const Context = preload("res://addons/use-context/context.gd")


func test_ctx_bucket():
	var ctx = Context.new()
	
	ctx.add("/", "abc")
	ctx.add("/", "abc1")
	ctx.add("/root", "abc2")
	
	assert_array(ctx.get("/")).is_equal(["abc", "abc1"])
	assert_array(ctx.get("/root")).is_equal(["abc2"])


func test_ctx_bucket_remove():
	var ctx = Context.new()
	
	ctx.add("/", "abc")
	ctx.add("/root", "abc2")
	
	ctx.erase("/", "abc")
	
	assert_array(ctx.get("/")).is_equal([])
	assert_array(ctx.get("/root")).is_equal(["abc2"])


func test_sanitaze():
	var ctx = Context.new()
	
	ctx.add("/", "abc")
	ctx.erase("/", "abc")
	
	assert_bool(ctx.has("/")).is_true()
	
	ctx.sanitize()
	
	assert_bool(ctx.has("/")).is_false()


func test_find():
	var ctx = Context.new()
	
	ctx.add("/", "abc")
	ctx.add("/", "abc2")
	
	var result = ctx.find(
		"/", 
		func(bucket: Array, opt): 
			for x in bucket:
				if x == "abc":
					return opt.found(x)
			return opt.not_found()
	)
	assert_str(result).is_equal("abc")
	
	result = ctx.find(
		"/", 
		func(bucket: Array, opt): 
			for x in bucket:
				if x == "abc3":
					return opt.found(x)
			return opt.not_found()
	)
	assert_result(result).is_null()


func test_find_from_child_path():
	var ctx = Context.new()
	
	ctx.add("/", "abc")
	ctx.add("/", "abc2")
	
	var result = ctx.find(
		"/child", 
		func(bucket: Array, opt): 
			for x in bucket:
				if x == "abc":
					return opt.found(x)
			return opt.not_found()
	)
	assert_str(result).is_equal("abc")
	
	result = ctx.find(
		"/child", 
		func(bucket: Array, opt): 
			for x in bucket:
				if x == "abc3":
					return opt.found(x)
			return opt.not_found()
	)
	assert_result(result).is_null()
