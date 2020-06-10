import QtQuick 2.0

Item {
    id: root
    signal itemSelected(int index)
    ListModel {
        id: menuModel
        ListElement {
            name: "Menu A"
        }

        ListElement {
            name: "Menu B >> "
        }

        ListElement {
            name: "Menu C"
        }
    }

    ListView {
        id: menuListView
        width: 300
        height: 300
        model: menuModel
        delegate: menuDelegate
        currentIndex: -1
        boundsBehavior: Flickable.StopAtBounds
    }

    Component {
        id: menuDelegate
        Rectangle {
            property var bgColor: "black"
            width: 300
            height: 100
            color: bgColor
            Text {
                text: name
                anchors.centerIn: parent
                color: "white"
                font.pixelSize: 25
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    bgColor = "green"
                    menuListView.currentIndex = index
                    delay.start()
//                    itemSelected(index)
                }
            }
        }
    }
    Timer {
        id: delay
        interval:100; running: false; repeat: false
        onTriggered: itemSelected(menuListView.currentIndex)
    }
}
