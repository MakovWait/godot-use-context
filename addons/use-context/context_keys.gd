const FindResultFactory = preload("./context.gd").FindResultFactory

static func by_type(type: Variant):
	return func(bucket: Array, opt: FindResultFactory):
		for x in bucket:
			if is_instance_of(x, type):
				return opt.found(x)
		return opt.not_found()
