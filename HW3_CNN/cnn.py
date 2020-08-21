# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'cnn.ui'
#
# Created by: PyQt5 UI code generator 5.9.2
#
# WARNING! All changes made in this file will be lost!

from PyQt5 import QtCore, QtGui, QtWidgets

class Ui_CNN(object):
    def setupUi(self, CNN):
        CNN.setObjectName("CNN")
        CNN.resize(778, 644)
        font = QtGui.QFont()
        font.setPointSize(9)
        CNN.setFont(font)
        CNN.setUnifiedTitleAndToolBarOnMac(False)
        self.centralwidget = QtWidgets.QWidget(CNN)
        self.centralwidget.setObjectName("centralwidget")
        self.pushButton = QtWidgets.QPushButton(self.centralwidget)
        self.pushButton.setGeometry(QtCore.QRect(620, 540, 93, 28))
        self.pushButton.setObjectName("pushButton")
        self.graphicsView = QtWidgets.QGraphicsView(self.centralwidget)
        self.graphicsView.setGeometry(QtCore.QRect(20, 60, 512, 512))
        self.graphicsView.setObjectName("graphicsView")
        self.label = QtWidgets.QLabel(self.centralwidget)
        self.label.setGeometry(QtCore.QRect(20, 20, 60, 23))
        font = QtGui.QFont()
        font.setPointSize(14)
        self.label.setFont(font)
        self.label.setObjectName("label")
        self.pushButton_2 = QtWidgets.QPushButton(self.centralwidget)
        self.pushButton_2.setGeometry(QtCore.QRect(620, 500, 93, 28))
        self.pushButton_2.setObjectName("pushButton_2")
        self.pushButton_3 = QtWidgets.QPushButton(self.centralwidget)
        self.pushButton_3.setGeometry(QtCore.QRect(620, 460, 93, 28))
        self.pushButton_3.setObjectName("pushButton_3")
        CNN.setCentralWidget(self.centralwidget)
        self.menubar = QtWidgets.QMenuBar(CNN)
        self.menubar.setGeometry(QtCore.QRect(0, 0, 778, 26))
        self.menubar.setObjectName("menubar")
        self.menuMenu = QtWidgets.QMenu(self.menubar)
        self.menuMenu.setObjectName("menuMenu")
        self.menuTools = QtWidgets.QMenu(self.menubar)
        self.menuTools.setObjectName("menuTools")
        self.menuView = QtWidgets.QMenu(self.menubar)
        self.menuView.setObjectName("menuView")
        self.menuFile = QtWidgets.QMenu(self.menubar)
        self.menuFile.setObjectName("menuFile")
        CNN.setMenuBar(self.menubar)
        self.statusbar = QtWidgets.QStatusBar(CNN)
        self.statusbar.setObjectName("statusbar")
        CNN.setStatusBar(self.statusbar)
        self.menubar.addAction(self.menuMenu.menuAction())
        self.menubar.addAction(self.menuTools.menuAction())
        self.menubar.addAction(self.menuView.menuAction())
        self.menubar.addAction(self.menuFile.menuAction())

        self.retranslateUi(CNN)
        QtCore.QMetaObject.connectSlotsByName(CNN)

    def retranslateUi(self, CNN):
        _translate = QtCore.QCoreApplication.translate
        CNN.setWindowTitle(_translate("CNN", "CNN"))
        self.pushButton.setText(_translate("CNN", "退出"))
        self.label.setText(_translate("CNN", "Image"))
        self.pushButton_2.setText(_translate("CNN", "识别"))
        self.pushButton_3.setText(_translate("CNN", "加载"))
        self.menuMenu.setTitle(_translate("CNN", "Menu"))
        self.menuTools.setTitle(_translate("CNN", "Tools"))
        self.menuView.setTitle(_translate("CNN", "View"))
        self.menuFile.setTitle(_translate("CNN", "File"))

