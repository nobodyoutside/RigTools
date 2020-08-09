import pymxs
from PySide2 import QtWidgets, QtCore, QtGui
rt = pymxs.runtime
class RigToolsPySide(QtWidgets.QDialog):
    def __init__(self, parent=MaxPlus.GetQMaxMainWindow()):
        super(RigToolsPySide, self).__init__(parent)
        self.CreateUI()
    def CreateUI(self):
        pass