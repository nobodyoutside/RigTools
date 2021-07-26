import pymxs
rt = pymxs.runtime
# SpeedCtrl
speed_ctrl_node =  rt.sliderManipulator( xPos=0.3 ,yPos=0.05, transform=rt.matrix3(1))
speed_ctrl_node.name = u'이동속도 컨트롤러'
speed_ctrl_node.sldName = u'초당이속'
speed_ctrl_node.snapVal = 1
speed_ctrl_node.maxVal = 17


# ExportMode
ctrl_label_name = u'Off <-- MoveMode --> On'
value_name = 'value'
ctrlBone_pos = (0.9, 0.05)
Root_node = rt.pickObject(message=u"연결더미 선택")
if Root_node == None:
	Root_node = rt.Point()
print(u"이동값을 {}에 적용합니다.\n".format(Root_node.name))
targetName_string = "enable_track"
Root_ypos_script_string = "start = F - animationRange.start \\ moveVale = speed * 3.33333\\ \\((start * moveVale) * {}) * -1".format(targetName_string)

Ctrl_node = rt.sliderManipulator( xPos=0.5 ,yPos=0.05, transform=rt.matrix3(1))
Ctrl_node.sldName = ctrl_label_name
Ctrl_node.snapVal = 1
rt.setPropertyController(Ctrl_node, value_name, rt.boolean_float())
Ctrl_node.value.controller = rt.boolean_float()
(rt.getPropertyController(Ctrl_node, value_name)).setmxsprop("keyable", False)
Ctrl_node.value.controller.keyable = False
rt.setPropertyController(Ctrl_node, "minVal", rt.Float_Expression())
Ctrl_node.minVal.controller = rt.Float_Expression()
max_ctrl = rt.Float_Expression()
max_ctrl.setExpression("1.0")
rt.setPropertyController(Ctrl_node, "maxVal", max_ctrl)
Ctrl_node.maxVal.controller = max_ctrl

enable_controller = rt.getPropertyController(Ctrl_node, value_name)
speed_controller = rt.getPropertyController(speed_ctrl_node, value_name)
enable_controller = Ctrl_node.value.controller
script_ctrl = rt.float_script()
script_ctrl.addTarget(targetName_string, enable_controller)
script_ctrl.addTarget(u'speed', speed_controller)
script_ctrl.setExpression( Root_ypos_script_string)
pos_ctrl = rt.getPropertyController(Root_node.controller, "Position")
rt.setPropertyController(pos_ctrl, "Y Position", script_ctrl)
Root_node.pos.controller.y_position.controller = script_ctrl

