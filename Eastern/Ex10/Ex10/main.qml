import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import "MyColor.js" as MyJS

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
            loader.sourceComponent = inforComponent
        }
    }

    Item {
        id: inforItem

        height: parent.height *14/15
        width: parent.width /2
        anchors.top: titletext.bottom
        anchors.left: memberItem.right

        Text {
            id: titleText

            height: parent.height /20
            width: parent.width
            font.pixelSize: text.height *2/3
            verticalAlignment: Text.AlignVCenter
            text: "Information"
            x: rect.x
        }

        Rectangle {
            id: rect

            height: parent.height *12/20
            width: parent.width * 9/10
            border.color: "black"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: titleText.bottom
            color: "transparent"

            Loader {
                id: loader

                anchors.fill: parent
            }
        }

        Component {
            id: inforComponent

            InformationForm {
                memberName: memberItem.currentName
                memberAge: memberItem.currentAge
                roleIndex: MyJS.getIndexFromRole(memberItem.currentRole)
                isAdd: false
                memberIndex: memberItem.currentMember
            }
        }
    }
}



