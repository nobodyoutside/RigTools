macroScript HiddenController
category:"_AniSeoHyun"
ToolTip:"rigging컨트롤러숨기기"
icon:#("VCRControls", 3)
(
ctrl_obj
hidden_obj
	

	

rollout 숨김컨트롤_rollout "aa"  autoLayoutOnResize:true 
(
	label ui_label "컴트롤러가 있은 오브젝트 이름"
	button ui_등록 "컨트롤러가 있는 오보즈게트 등록하기"
	label ui_label2 "숨겨질 오브젝트 등록하기"
	button ui_등록2 "값에 의해 숨겨질 오브젝트 등록하기"
	radiobuttons  ui_radiobuttons "컨트롤 값이 있는 축" labels:#(#x,#y,  #z)
	button ui_실행 "스크립트 적용"
	fn ui_updat = (
		if ctrl_obj != undefined do ui_label.text = ctrl_obj.name
		if hidden_obj != undefined do ui_label2.text = hidden_obj.name
	)
	on ui_등록 pressed do (
		ctrl_obj = (selection as array)[1]
		ui_updat()
	)
	on ui_등록2 pressed do (
		hidden_obj = (selection as array)[1]
		ui_updat()
	)
)
CreateDialog 숨김컨트롤_rollout 300 250 style:#(#style_resizing,#style_titlebar, #style_border, #style_sysmenu)

)