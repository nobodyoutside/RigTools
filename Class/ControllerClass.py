import pymxs
rt = pymxs.runtime
class ControllerClass():
    m_rot_name = 'Rotation'
    m_pos_name = 'Position'
    m_scale_name = 'Scale'
    def __init__(self):
        pass
    def SetBoneLength(self, bone, length):
        bone.length = length
    def SetTcbRotController(self, objs):
        value_name = ''
        for obj in objs:
            tcb_rot = rt.TCB_Rotation()
            enable_controller = rt.getPropertyController(obj, self.m_rot_name)