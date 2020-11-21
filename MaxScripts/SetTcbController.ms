fn SetTcbController arg_target_nodeArray:(selection as array) =
(
	target_nodeArray = arg_target_nodeArray
	for bone_node in target_nodeArray do 
	(
		bone_node.rotation.controller = tcb_rotation ()
	)
)
SetTcbController()
