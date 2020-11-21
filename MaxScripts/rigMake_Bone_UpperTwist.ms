rollout RigMake_UpperTwistBone "어께본 생성"
(
    clavcle_node = undefined
    upperArm_node = undefined
    forearm_node = undefined

    pickbutton ui_getClavcle "Clavcle 지정"
    pickbutton ui_getUpperArm "upperArm 지정"
    pickbutton ui_forearm "Forearm 지정"
    button ui_run "생성"


    on ui_getClavcle picked obj do (
        clavcle_node = obj
    )
    on ui_getUpperArm picked obj do (
        upperArm_node = obj
    )
    on ui_forearm picked obj do (
        forearm_node = obj
    )
    on ui_run pressed do (
        if clavcle_node != undefined and upperArm_node != undefined and forearm_node != undefined do (
            shoulderUpNode = point()
            shoulderUpNode.name = 'Bone ShoulderUpNode'
            shoulderUpNode.pos.controller = Position_Constraint()
            shoulderUpNode.rotation.controller = LookAt_Constraint()
            shoulderUpNode.appendTarget clavcle_node 100
            
        )
    )
)