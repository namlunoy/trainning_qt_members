import QtQuick 2.0

Item {
    signal itemSelected(int indexClicked)
    ListModel {
        id : model2

        ListElement {
            name : "Menu C"
        }
        ListElement {
            name : "Menu D"
        }
        ListElement {
            name : "<< Back"
        }
    }
    Component {
        id : delegateList2
        Rectangle{
            id : itemDelegate2
            height: 100
            width: parent.width
            color: "black"
            Text{
                text : name
                font.pixelSize: 40
                anchors.centerIn: parent
                color: "white"
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log(index)
                    listView2.currentIndex = index
                    itemSelected(index)
                    itemDelegate2.color = "blue"
                }
            }
            onFocusChanged: {
                itemDelegate2.color = "black"
            }

        }
    }
    ListView {
        id : listView2
        anchors.fill: parent
        model : model2
        delegate: delegateList2
    }
}
