import QtQuick 2.0

Item {
    signal selectMenu(int idx)
    width: 320
    height: 480

    ListModel {
        id: listMenu
        ListElement {
            name: "Menu A"
        }

        ListElement {
            name: "Menu B >>"
        }

        ListElement {
            name: "Menu C"
        }
    }

    Component {
        id: listDelegate

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
                    listView.currentIndex = index
                    bgcolor = "green"
                    selectMenu(index)
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
        model: listMenu
        delegate: listDelegate
        currentIndex: -1
    }
}
