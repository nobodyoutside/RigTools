-- 컨트롤러 TCB 변경
fn SetRotControllerToTCB target_nodeArray:(selection as array) =
(
	for obj_node in target_nodeArray do 
	(
		obj_node.rotation.controller = tcb_rotation()
		format  "% 컨트롤러 tbc로 변경 \n" obj_node.name
	)
)
SetRotControllerToTCB()