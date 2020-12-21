import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

ApplicationWindow {
    id: windowApp

    property var newWindow: null

    function createNewWindow(url) {
        var component = Qt.createComponent(url)
        newWindow = component.createObject(windowApp)
        newWindow.show()
    }

    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")
    menuBar: MenuBar {
        Menu {
            title: "File"

            MenuItem {
                text: "Add New Member"
                shortcut: "Ctrl+A"
                onTriggered: {
                    createNewWindow("AddWindow.qml")
                }
            }

            MenuItem {
                text: "Quit"
                shortcut: "Ctrl+Q"
                onTriggered: {
                    windowApp.close()
                }
            }
        }

        Menu {
            title: "Help"
            MenuItem {
                text: "About"
                onTriggered: {
                    createNewWindow("AboutWindow.qml")
                }
            }
        }
    }

    Connections {
        target: newWindow
        onAddMember: {
            memberItem.addMember(name, age, role)
            newWindow.close()
        }
    }

    Text {
        id: titletext

        height: parent.height /15
        width: parent.width
        font.pixelSize: titletext.height *2/3
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        text: "Team Management"
    }

    Member {
        id: memberItem

        height: parent.height *14/15
        width: parent.width /2
        anchors.top: titletext.bottom
        objectName: "memberObj"
        onChooseMember: {
            inforItem.loadInfo(memberItem.currentName, memberItem.currentAge, memberItem.currentRole)
        }
    }

    Information {
        id: inforItem

        height: parent.height *14/15
        width: parent.width /2
        anchors.top: titletext.bottom
        anchors.left: memberItem.right
        onDeleteMember: {
            memberItem.deleteMember(memberItem.currentMember)
        }

        onUpdateMember: {
            memberItem.updateMember(memberItem.currentMember, name, age, role)
        }
    }
}



