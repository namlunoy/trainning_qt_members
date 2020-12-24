import QtQuick 2.0
import QtQuick.Controls 2.12
import "Utils.js" as Utils

Rectangle {
    id: root
    y: 20
    width: parent.width - 30
    height:  parent.height - 20
    border.color: "lightgrey"
    border.width: 1
    anchors.horizontalCenter: parent.horizontalCenter
    Rectangle {
        id: teamMembers
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

        Button {
            onClicked: {
                console.log("forcelayout");
                membersView.forceLayout();
            }
        }

        Component {
            id: memberDelegate
            Rectangle {
                width: teamMembers.width
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
                        Utils.getRoleColor(role)
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

                ListView.onAdd: {
                    membersView.currentIndex = index;
                    membersView.positionViewAtIndex(membersView.count, ListView.Beginning);
                    myListModel.select(membersView.currentIndex);
                }

                ListView.onRemove: {
                    if (membersView.currentIndex >= membersView.count) {
                        membersView.currentIndex = membersView.count - 1;
                        myListModel.select(membersView.currentIndex);
                    }
                }
            }
        }
    }
}


