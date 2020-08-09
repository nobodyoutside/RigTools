--본 레인지 조정
boneLength_editWindow = rollout BoneLengthEdit "본 및 더미  길이 조정" width:300
(
	local m_pointHelper = undefined
	local m_tm = matrix3 1
	spinner length_rnage "본 및 더미 길이 조정" range:[0,999,50]
	button selectBone "본 및 더미 길이 확인"
	button setBoneLength "본 및 더미 길이 적용"
	fn GetLength =
	(
		if getclassName $ =="Bone" do length_rnage.value = $.length
		if getclassName $ =="Dummy" do
		(	
			boxsize = $.boxsize
			length_rnage.value = (boxsize[1] + boxsize[2] + boxsize[3]) / 3
		)
	)
	fn SetLength val =
	(
		if getclassName $ =="Bone" do $.length = val
		if getclassName $ =="Dummy" do
		(	
			$.boxsize = [val, val, val]
		)
	)
	on selectBone pressed do 
	(
		GetLength()
	)
	on setBoneLength pressed do 
	(
		SetLengthlength_rnage.value
	)
	on length_rnage changed  val do 
	(
		SetLength val
	)
	on bonelengtheidt open do 
	(
		GetLength()
	)
)
createDialog BoneLengthEdit pos:[100,100] style:#(#style_titlebar, #style_border, #style_sysmenu, #style_minimizebox)