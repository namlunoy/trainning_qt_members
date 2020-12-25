import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.2

ApplicationWindow {
    id: mainWindow
    visible: true
    width: 640
    height: 480
    title: qsTr("Working with ListView")

    menuBar: MenuBar {
        Menu {
            title: "File"
            Action {
                text: "Add New Members..."
                onTriggered: {
                    addNewWindow.show();
                }
            }
            MenuSeparator {}
            Action {
                text: "Quit"
                onTriggered: {
                    Qt.callLater(Qt.quit)
                }
            }
        }
        Menu {
            title: "Help"
            Action {
                text: "About"
                onTriggered: {
                    aboutWindow.show()
                }
            }
        }
    }

    Text {
        y: 15
        text: "Team Management"
        font.pointSize: 16
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Rectangle {
        width: 600
        height: 360
        y: 50
        anchors.horizontalCenter: parent.horizontalCenter

        Rectangle {
            width: 300
            height: parent.height
            anchors.left: parent.left
            Text {
                x: 20
                text: "Team Members"
            }

            TeamMembersForm {
                id: members
            }
        }

        Rectangle {
            width: 300
            height: parent.height
            anchors.right: parent.right
            Text {
                x: 20
                text: "Informations"
            }

            InformationForm {
                isAdd: false
            }
        }

        AddNewMemberWindow {
            id: addNewWindow
            width: 300
            height: 380
            modality: Qt.WindowModal
        }

        ApplicationWindow {
            id: aboutWindow
            title: "Program Informations"
            width: 400
            height: 60
            modality: Qt.WindowModal

            Text {
                x: 20
                text: "Author: Nghiem Xuan Chinh"
                font.pointSize: 10
                font.bold: true
                color: "red"
            }

            Text {
                x: 20
                y: 20
                text: "Version: 1.0"
                font.pointSize: 10
                font.bold: true
                color: "red"
            }
        }
    }
}
