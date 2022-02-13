custAttributes.redefine (custAttributes.getDef $ 1) \
"attributes Custom_Attributes version:0
(
    parameters main rollout:params
    (
        'TargetObject' Type:#node subAnim:true UI:'TargetObject'
    )

    rollout params \"Choose Target\"
    (
        pickbutton 'TargetObject' \"TargetObject\" Width:150 Height:25 Align:#Center Offset:[0,0] Type:#node autoDisplay:true
    )
)"
undefined