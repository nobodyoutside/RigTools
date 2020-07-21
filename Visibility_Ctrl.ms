--오브젝트 가시성 컨틀로러 생성
struct Visibility_Ctrl
(
	fn Run =
	(
		ctrol_bone = pickObject message:"컨트롤본 선택" prompt:"컨트롤본 선택"
		target_mesh = pickObject message:"대상메쉬" prompt:"대상메쉬"
		if ctrol_bone != undefined and target_mesh != undefined do 
		(
			visibility_script = float_script()
			script_val_string = "target_float"
			target_track = ctrol_bone.pos.controller.z_position.controller
			visibility_script.addTarget script_val_string target_track
			visibility_script.setExpression script_val_string
			target_mesh.Visibility = visibility_script
		)
	),
	on create do
	(
		format "Struct Created: %\n" this
		Run()
	)
)
Visibility_Ctrl()
