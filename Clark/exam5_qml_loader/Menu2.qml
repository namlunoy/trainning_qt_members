import QtQuick 2.0

Item {
    signal selectMenu(int idx)
    width: 320
    height: 480

    ListModel {
        id: extendListMenu
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

    Component {
        id: extendListDelegate
        Rectangle {
            property string bgcolor: "black"
            width: 320
            height: 160
            color: bgcolor
            Text {
                text: qsTr(name)
                font.pixelSize: 25
                color: "white"
                anchors.centerIn: parent
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    listView.currentIndex = index // change focus
                    bgcolor = "blue"
                    selectMenu(index) // emit signal
                }
            }

            onFocusChanged: {
                bgcolor = "black"
            }
        }
    }

    ListView {
        id: listView
        anchors.fill: parent
        model: extendListMenu
        delegate: extendListDelegate
    }
}
