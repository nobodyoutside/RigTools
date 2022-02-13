changeSkinWeightBone
-- version = 1.2
-- 2021-07-26 11:46:36 맥스 2018에서  skinOps.GetBoneNode 함수가 없음 
-- 2021-07-27 12:24:38 struct 오류
-- 2021-07-27 14:05:55 함수(GetBoneNodeByIndex 리턴) 오류
-- 2021-07-27 18:45:51 버전오류( GetSelectedVertices 함수 추가)
--2021-07-30 12:02:10 skinMod 오타수정
struct SH_SkinTool
(
    version = 1.2,
    fn  GetMaxVersion  =
    (
        local  oldest  =  (maxversion())[1]/1000
        if  oldest  <  12  then  oldest  =  12
        validVersions  =  1998  +  oldest
    ),
    fn IsOldMaxVersion = (
        -- 2020 이하 버전인지
        isOldversion = False
        v = SH_SkinTool.GetMaxVersion()
        if v < 2020 do (
            isOldversion = true
        )
        isOldversion
    ),
    fn UpDateWeightTool skinNode = (
        if skinOps.isWeightTableOpen skinNode do (
            skinOps.closeWeightTable skinNode
            skinOps.buttonWeightTable skinNode 
        )
        if skinOps.isWeightToolOpen skinNode do (
            skinOps.closeWeightTool skinNode
            skinOps.WeightTool skinNode
        )
    ),
    fn GetSkinVertexByBoneIndex skinMod boneIndex = (
        boneVertexs = #()
        vertex_num = skinOps.GetNumberVertices skinMod
        for vert_index = 1 to vertex_num do (
            for weight_index = 1 to (skinOps.GetVertexWeightCount skinMod vert_index) do (
                weight_BoneIndex = skinOps.GetVertexWeightBoneID skinMod vert_index weight_index
                if weight_BoneIndex == boneIndex do append boneVertexs vert_index
            )
        )
        boneVertexs
    ),
    fn GetSkinBoneIndexByNode skinModifier boneNode = (
        skinOps.selectBoneByNode skinModifier boneNode
        boneID_index = skinOps.GetSelectedBone skinModifier
        return boneID_index
    ),
    fn ChangeWeight skinModifier currentBoneIndex newBoneIndex vert_list = (
        for vert_index in vert_list do (
            boneIndexArray = #()
            weightValeArray = #()
            target_index = undefined
            for weight_index = 1 to (skinOps.GetVertexWeightCount skinModifier vert_index) do (
                t_index = skinOps.GetVertexWeightBoneID skinModifier vert_index weight_index
                if t_index == currentBoneIndex then
                (
                    target_index = weight_index
                    append boneIndexArray newBoneIndex
                )
                else (
                    append boneIndexArray t_index
                )
                append weightValeArray (skinOps.GetVertexWeight skinModifier vert_index weight_index)
            )
            if target_index != undefined do (
                tempList = makeUniqueArray boneIndexArray
                if tempList.count != boneIndexArray.count do (
                    newBoneList = #()
                    newBoneWeight = #()
                    etcBoneList = #()
                    etcBoneWeight = #()
                    for i = 1 to boneIndexArray.count do (
                        if boneIndexArray[i] == newBoneIndex then(
                            append newBoneList boneIndexArray[i]
                            append newBoneWeight weightValeArray[i]
                        ) else (
                            append etcBoneList boneIndexArray[i]
                            append etcBoneWeight weightValeArray[i]
                        )
                    )
                    newWeight = 0
                    for val in newBoneWeight do newWeight += val
                    append etcBoneList newBoneIndex
                    append etcBoneWeight newWeight
                    boneIndexArray = etcBoneList
                    weightValeArray = etcBoneWeight
                )
                skinOps.ReplaceVertexWeights skinModifier vert_index boneIndexArray weightValeArray
            )
        )
    ),
    fn GetBoneNodeByIndex skinMod boneIndex = (
        -- 맥스 2018에서 작동이 안되는 현상이 발견되어서 수정
        -- skinOps.GetBoneNode 함수가 없음
        node = undefined
        if SH_SkinTool.IsOldMaxVersion() then (
            boneName = skinOps.GetBoneName skinMod boneIndex 0
            node = getNodeByName boneName
        )else(
            node = skinOps.GetBoneNode skinMod boneIndex
        )
        node
    ),
    fn GetBoneNodes skinMod = (
        bones = #()
        if SH_SkinTool.IsOldMaxVersion() then (
            maxBonesNum = skinOps.GetNumberBones skinMod
            for boneNum = 1 to maxBonesNum do (
                boneName = skinOps.GetBoneName skinMod boneNum 0
                append bones (getNodeByName boneName)
            )
        )else(
            bones = skinOps.GetBoneNodes skinMod
        )
        bones
    ),
    fn GetSelectedVertices skinMod = (
        selectVertices = #()
        if SH_SkinTool.IsOldMaxVersion() then (
            vertex_num = skinOps.GetNumberVertices skinMod
            for vert_index = 1 to vertex_num do (
                if skinOps.IsVertexSelected skinMod vert_index == 1 do (
                    append selectVertices vert_index
                )
            )
        ) else(
            selectVertices = skinOps.getSelectedVertices skinMod
        )
        selectVertices 
    )
)

rollout changeSkinWeightBone "SkinBone Tool" width:240
(
    local currentBoneNode = undefined
    local newBoneNode = undefined
    local skinNode = undefined
    local currentBoneNamePreText = "Current Bone Name : "
    local newBoneNamePreText = "New Bone Name : "

    group "[.....]"
    (
        label log_text "오브젝트를 선택하고 버튼 클릭하세요."
    )
    group "Current Bone"
    (
        button pickCurrentBone "pick current Bone" across:2
        button pickCurrentBoneList "Get Bone By List "
        label currentBoneName currentBoneNamePreText
    )
    group "New Bone"
    (
        button pickNewBone "Pick New Bone" across:2
        button pickNewBoneList "Get Bone By List"
        label newBoneName newBoneNamePreText
    )
    group "Run"
    (
        label run_text "실행 대기중..."
        button run "run"
    )
    group "option"
    (
        checkbox enableSelect "선택한 버택스만 교체"  checked:true
    )
    fn UpdateName = (
        if currentBoneNode != undefined do (
            currentBoneName.text = currentBoneNamePreText +  currentBoneNode.name
        )
        if newBoneNode != undefined do (
            newBoneName.text = newBoneNamePreText + newBoneNode.name
        )
        if skinNode == undefined do (
            log_text.text = "스킨 오브젝트를 선택하고 Run을 눌러주세요."
            run_text.text = "준비중"
        )
        if currentBoneNode == undefined do (
            log_text.text = "Current Bone 선택되지 않았습니다."
            currentBoneName.text = currentBoneNamePreText
            run_text.text = "준비중"
        )
        if newBoneNode == undefined do (
            log_text.text = "new Bone 선택되지 않았습니다."
            newBoneName.text = newBoneNamePreText
            run_text.text = "준비중"
        )
        if newBoneNode == undefined and currentBoneNode == undefined  do (
            log_text.text = "작업할 본들이 선택되지 않았습니다."
            run_text.text = "준비중"
        )
        if currentBoneNode != undefined and newBoneNode != undefined  do (
            run_text.text = currentBoneNode.name + "의 값을 " + newBoneNode.name + "로 대체합니다."
            log_text.text = "준비 완료.."
        )
    )
    fn isSkinNode = (
        isSkin = false
        if iskindof skinNode Skin do isSkin = true
        isSkin
    )
	on changeSkinWeightBone open do
	(
		
	)
    on pickCurrentBone pressed do 
    (
        currentBoneNode = $
        UpdateName()
    )
    on pickCurrentBoneList pressed do 
    (
        skinNode = modPanel.getcurrentObject()
        if isSkinNode() do(
            bone_index = skinOps.GetSelectedBone skinNode
            currentBoneNode = SH_SkinTool.GetBoneNodeByIndex skinNode bone_index
            -- currentBoneNode = skinOps.GetBoneNode skinNode bone_index
        )
        UpdateName()
    )
    on pickNewBone pressed do 
    (
        newBoneNode = $
        UpdateName()
    )
    on pickNewBoneList pressed do 
    (
        skinNode = modPanel.getcurrentObject()
        if isSkinNode() do(
            bone_index = skinOps.GetSelectedBone skinNode
            -- newBoneNode = skinOps.GetBoneNode skinNode bone_index
            newBoneNode = SH_SkinTool.GetBoneNodeByIndex skinNode bone_index
        )
        UpdateName()
    )
    on run pressed do
    (
        run_text.text = "실행중...."
        setCommandPanelTaskMode mode:#modify
        skinNode = modPanel.getcurrentObject()
        if not isSkinNode() do (
            log_text.text = "skinNode 가 유요하지 않음."
            run_text.text = "실행 대기중..."
        )
        -- node가 유요한지 체크
        -- bones = skinOps.GetBoneNodes skinNode 버전분제로 수정
        bones = SH_SkinTool.GetBoneNodes skinNode
        sel_vertx = SH_SkinTool.GetSelectedVertices skinNode
        if enableSelect.state and sel_vertx.count == 0 do return (
            log_text.text = "선택한 버택스가 없습니다."
            run_text.text = "실행 대기중...")
        if findItem bones currentBoneNode == 0 do return(
            log_text.text = "currentBoneNode 가 유요하지 않음."
            run_text.text = "실행 대기중..."
        )
        if findItem bones newBoneNode == 0 do return(
            log_text.text = "newBoneNode 가 유요하지 않음."
            run_text.text = "실행 대기중..."
        )
        undo on
        (
            disableSceneRedraw() 
            currentBoneIndex = SH_SkinTool.GetSkinBoneIndexByNode skinNode currentBoneNode
            newBoneIndex = SH_SkinTool.GetSkinBoneIndexByNode skinNode newBoneNode
            vert_index_arr = #()
            if enableSelect.state then (
                vert_index_arr = sel_vertx
            )
            else(
                vert_index_arr = SH_SkinTool.GetSkinVertexByBoneIndex skinNode currentBoneIndex
            )
            SH_SkinTool.ChangeWeight skinNode currentBoneIndex newBoneIndex vert_index_arr
            enableSceneRedraw() 
        )
        redrawViews()
        log_text.text = "완료"
        run_text.text = "실행 대기중..."
        SH_SkinTool.UpDateWeightTool skinNode
    )
)
createDialog changeSkinWeightBone  style:#(#style_toolwindow, #style_sysmenu, #style_resizing)