static func by_script(script):
	return func(bucket: Array, opt):
		for x in bucket:
			if x is Object and x.get_script() == script:
				return opt.found(x)
		return opt.not_found()
