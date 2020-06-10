import QtQuick 2.0

Item {
    signal itemSelected(int indexClicked)
    ListModel {
        id : model1

        ListElement {
            name : "Menu A"
        }
        ListElement {
            name : "Menu B >>"
        }
        ListElement {
            name : "Menu C"
        }
    }
    Component {
        id : delegateList1
        Rectangle{
            id : itemDelegate1
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
                    listView1.currentIndex = index
                    itemSelected(index)
                    itemDelegate1.color = "green"
                }
            }
            onFocusChanged: {
                itemDelegate1.color = "black"
            }

        }
    }
    ListView {
        id : listView1
        anchors.fill: parent
        model : model1
        delegate: delegateList1
    }
}
