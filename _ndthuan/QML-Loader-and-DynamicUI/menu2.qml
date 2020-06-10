import QtQuick 2.0

Item {
    id: root
    signal itemSelected(int index)
    ListModel {
        id: menuModel
        ListElement {
            name: "Menu C"
        }

        ListElement {
            name: "Menu D"
        }

        ListElement {
            name: "<< Back"
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
                font.pixelSize: 25
                color: "white"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    menuListView.currentIndex = index
                    bgColor = "blue"
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
