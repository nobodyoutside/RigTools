-- Root Move
--Root_node = getNodeByName "Root"
Root_node = pickObject message:"이동값 적용 물체 선택" prompt:"이동값 적용할 것 선택"
if Root_node == undefined do Root_node = Point()
format "이동값을 %에 적용합니다.\n" Root_node.name
targetName_string ="enable_track"
Root_ypos_script_string ="((F * 10) * "+ targetName_string  +") * -1"

Ctrl_node = sliderManipulator xPos:0.5 yPos:0.05 transform:(matrix3 [0,1,0] [0,0,1] [1,0,0] [0,0,0])
Ctrl_node.sldName = "RootMove"
Ctrl_node.value.controller = boolean_float()
Ctrl_node.minVal = 0.0
Ctrl_node.maxVal = 1.0

enable_controller = Ctrl_node.value.controller
script_ctrl = float_script()
script_ctrl.addTarget targetName_string enable_controller
script_ctrl.setExpression Root_ypos_script_string
Root_node.pos.controller.y_poition = script_ctrl

--on off 보다 이동값을 0~숫치로 제어하는게 편할 듯
