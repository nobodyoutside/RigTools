obj = $
for i = 1 to 3 do (
	for ii = 1 to 3 do (
		--obj.controller[i][ii].controller.keyable = false
		--tm = obj.controller[i][ii]
		tm = obj.controller[i][ii]
		print tm
		--print (hasProperty tm "controller")
		if tm != undefined  do(
			tm.controller.keyable = false
			--print tm + " :keyable is false"
		)
	)
)