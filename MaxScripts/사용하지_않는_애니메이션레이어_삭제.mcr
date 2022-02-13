macroScript 사용하지_않는_레이어삭제
category:"_AniSeoHyun"
tooltip:"rigging_사용하지_않는_애니메이션레이어_삭제"
--icon:#("VCRControls", 3)
(

	index_list = AnimLayerManager.getActiveLayersNodes (Objects as array)
	for i = AnimLayerManager.getLayerCount() to 2 by -1 do (
		if (findItem  index_list i ) do continue
		print(AnimLayerManager.getLayerName i)
		AnimLayerManager.deleteLayer i
	)
	print("삭제완료")
)