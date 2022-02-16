macroScript 숨김컨트롤러선택_버튼
category:"_AniSeoHyun"
tooltip:"숨김컨트롤러선택_버튼"
--icon:#("VCRControls", 3)
(
	target_nodes = selection as array 
	for obj_node in target_nodes do (
		att_data  = attributes ctrl_pick version:3 (
			parameters main rollout:params (
				visibility type:#integer 
				InvertHide type:#boolean
			)
			rollout params "컨트롤본용 Node 선택하기" ( 
				radiobuttons  aixs_select "적용할 축 선택"  labels:#("x", "y", "z") columns:3
				pickbutton pick "선택"
				checkbox  invert_button "활성화시 숨김 반전"
				
				on pick picked obj do (
					--node_id = obj.handle 
					--pick.text = obj.name
					sc = float_script()
					script_val_string = "target_float"
					target_track = obj.pos.controller.x_position.controller
					target_track = case aixs_select.state of
					(
						1: obj.pos.controller.x_position.controller
						2: obj.pos.controller.y_position.controller
						3: obj.pos.controller.z_position.controller
						default: obj.pos.controller.x_position.controller
					)
					sc.addTarget script_val_string target_track
					sc.setExpression script_val_string
					visibility.controller = sc
				)
				on invert_button changed arg do (
					InvertHide = arg
				)
				on params open do(
					invert_button.state = InvertHide
				)
			)	
		)
		custAttributes.add obj_node att_data

		obj_node.InvertHide.controller = boolean_float()
		
		vsc = float_script()
		script_val_string = "value = 1 ; if self_node != undefined do (value = self_node.ctrl_pick.visibility ;  if  self_node.ctrl_pick.invertHide do ( value = abs(value - 1)) ); if  value == 0 then (self_node.isHidden = true) ; else ( self_node.isHidden = false);  value"
		self_node_string = "self_node"
		vsc.AddNode self_node_string obj_node
		vsc.setExpression script_val_string
		obj_node.visibility = vsc

	print("컨트롤러 적용완료")
	)
)
