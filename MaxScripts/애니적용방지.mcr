
macroScript KeyableSetting
category:"_AniSeoHyun"
ToolTip:"애니 안되게 함"
(
	struct KeyableSetting
	(
		nodes = #(),
		log_label = "",
		label_text = "",
		enableKeyables = #(true, true, true),
		fn GetLogLabelText = (
			outText = copy log_label
			free log_label
			outText
		),
		fn GetLabeText = (
			label_text = "오브젝트를 선택해주세요."
			if nodes.count > 0 do (
				label_text = nodes[1].name
			)
			if nodes.count > 1 do (
				label_text = label_text + " + " + (nodes.count as string)
			)
			label_text
		),
		fn buttonClick = if nodes.count > 0  do (
			for obj in nodes do (
				for i = 1 to 3 do (
					for ii = 1 to 3 do (
						tm = obj.controller[i][ii]
						if tm != undefined  do(
							tm.controller.keyable = enableKeyables[i]
						)
					)
				)
			)
			log_label = log_label + "작업완료. \n"
		),
		fn SetEnableKeyables p r s = (
			enableKeyables = #(not p, not r, not s)
			log_label = log_label +"옵션체크 \n"
		),
		fn SetNodes = (
			nodes = selection as array
			log_label = log_label + "선택완료. \n"
			GetLabeText()
		),
		on create do (
			SetNodes()
			GetLabeText()
		),
		on close do (

		)
	)
	KeyableSettingFn = KeyableSetting()
	rollout KeyableRollout "애니 안되게 함" autoLayoutOnResize:true 
	(
		label selectLabel "선택한 오브젝트 : " offset:[0, 0] align:#left across:3
		label nodeName offset:[0, 0]
		button setNode_button "선택" width:80 offset:[0, 0] align:#right
		group "Satting"
		(
			label dic "체크한 컨트롤러의 애니메이션을 할 수 없게 만듭니다." offset:[0, 0]
			label dic2 "체크 해제한 컨트롤러는 다시 애니메이션을 적용 할 수있습니다." offset:[0, 0]
			checkbox pos_checkbox "Position" offset:[0,0] across:3
			checkbox rot_checkbox "Rotation" offset:[0,0]
			checkbox scale_checkbox "Scale" offset:[0,0]
		)
		button onKeyable_button "적용" width:80 offset:[0, 0]
		group ""
		(
			label log_label "" offset:[0, 0]
		)
		fn updateRollout = (
			nodeName.text =	KeyableSettingFn.GetLabeText()
			log_label.text = KeyableSettingFn.GetLogLabelText()
		)
		on onKeyable_button pressed do (
			KeyableSettingFn.buttonClick()
			updateRollout()
		)
		on setNode_button pressed do (
			KeyableSettingFn.SetNodes()
			updateRollout()
		)
		on pos_checkbox changed state do
		(
			KeyableSettingFn.SetEnableKeyables pos_checkbox.state rot_checkbox.state scale_checkbox.state
			updateRollout()
		)
		on rot_checkbox changed state do
		(
			KeyableSettingFn.SetEnableKeyables pos_checkbox.state rot_checkbox.state scale_checkbox.state
			updateRollout()
		)
		on scale_checkbox changed state do
		(
			KeyableSettingFn.SetEnableKeyables pos_checkbox.state rot_checkbox.state scale_checkbox.state
			updateRollout()
		)

		on KeyableRollout resized size do (
			updateRolloutLayout KeyableRollout
		)
		on KeyableRollout open do
		( 
			KeyableSettingFn.SetNodes()
			updateRollout()
		)
	)
	createdialog KeyableRollout 345 200 style:#(#style_resizing, #style_titlebar, #style_border, #style_sysmenu)
)
