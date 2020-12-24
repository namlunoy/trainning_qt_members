import QtQuick 2.0
import QtQuick.Controls 2.12

Rectangle {
    y: 20
    width: parent.width - 30
    height:  parent.height - 20
    border.color: "lightgrey"
    border.width: 1
    anchors.horizontalCenter: parent.horizontalCenter

    function getRoleColor(role) {
        switch(role) {
        case 0: case "Team Leader":
            return "yellow";
        case 1: case "Developer":
            return "blue";
        case 2: case "BA":
            return "red";
        case 3: case "Tester":
            return "green";
        }
    }

    Rectangle {
        width: parent.width - 20
        height: parent.height - 20
        anchors.centerIn: parent

        ListView {
            id: membersView
            clip: true

            model: myListModel
            delegate: memberDelegate
            anchors.fill: parent
        }

        Component {
            id: memberDelegate
            Rectangle {
                width: parent.width
                height: 40

                Rectangle {
                    id: bg
                    anchors.fill: parent
                    color: "lightgrey"
                    opacity: 0.0
                }

                Rectangle {
                    width: parent.height
                    height: parent.height
                    color: {
                        getRoleColor(role)
                    }
                    border.color: "black"
                    border.width: 1
                }

                Text {
                    x: parent.height + 10
                    anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 15
                    text: name
                }

                Text {
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 15
                    text: age
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        membersView.currentIndex = index;
                        myListModel.select(index);
                    }
                }

                onFocusChanged: {
                    if (focus)
                        bg.opacity = 0.5
                    else
                        bg.opacity = 0.0
                }

                ListView.onRemove: {
                    if (membersView.currentIndex >= membersView.count) {
                        membersView.currentIndex = membersView.count - 1;
                    }
                    myListModel.select(membersView.currentIndex);
                }
            }
        }
    }
}


