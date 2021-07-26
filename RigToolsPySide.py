import pymxs
from PySide2 import QtWidgets, QtCore, QtGui
rt = pymxs.runtime
class RigToolsPySide(QtWidgets.QDialog):
    m_mainLayout = QtWidgets.QVBoxLayout()
    m_scritListView = QtWidgets.QListWidget()
    def __init__(self, parent=MaxPlus.GetQMaxMainWindow()):
        super(RigToolsPySide, self).__init__(parent)
        self.CreateUI()
        self.setLayout(self.m_mainLayout)
    def CreateUI(self):
        pass