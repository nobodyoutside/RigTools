macroScript 오브젝트에_커스텀_속성_삭제
category:"_AniSeoHyun"
tooltip:"rigging_오브젝트에_커스텀_속성_삭제"
--icon:#("VCRControls", 3)
(
	target_nodes = selection as array 
	for obj in target_nodes do (
		num =  custattributes.count obj
		for i = 1 to num do (
			custattributes.delete obj i
		)
	)
	print("삭제완료")
)