--원형 ref도우미 생성
ref_root = Circle radius:15
ref_mesh = Cylinder height:0 heightsegs:1
ctrol_bone = Bone()
ref_mesh.parent = ref_root
ctrol_bone.parent = ref_mesh
ctrol_bone.pos.controller.X_Position.controller = float_limit ()
ctrol_bone.pos.controller.X_Position.controller.lower_limit = 0
ctrol_bone.pos.controller.X_Position.controller.upper_limit_enabled = off
ctrol_bone.pos.controller.Y_Position.controller = float_limit ()
ctrol_bone.pos.controller.Y_Position.controller.lower_limit = 0
ctrol_bone.pos.controller.Y_Position.controller.upper_limit = 0
ctrol_bone.pos.controller.Z_Position.controller = float_limit ()
ctrol_bone.pos.controller.Z_Position.controller.lower_limit = 0
ctrol_bone.pos.controller.Z_Position.controller.upper_limit = 0
radius_script = float_script()
script_val_string = "target_float"
target_track = ctrol_bone.pos.controller.x_position.controller
radius_script.addTarget script_val_string target_track
radius_script.setExpression script_val_string
ref_mesh.radius.controller = radius_script
freeze ref_mesh
select ref_root
