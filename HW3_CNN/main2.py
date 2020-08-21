import sys
from PyQt5.QtWidgets import QApplication,QMainWindow

import cnn

def click_success():
    print("成功")

if __name__ == "_main_":
    #
    app = QApplication(sys.argv)
    MainWindow = QMainWindow()
    ui = cnn.Ui_CNN()
    ui.setupUi(MainWindow)
    MainWindow.show()
    ui.pushButton_3.clicked.connect(click_success)
    sys.exit(app.exec_())
