import QtQuick 2.0
import MemberModel 1.0
import "Utils.js" as Utils

Rectangle {
    id: root
    y: 20
    width: parent.width - 30
    height:  parent.height - 20
    border.color: "lightgrey"
    border.width: 1
    anchors.horizontalCenter: parent.horizontalCenter

    signal selectMember(int idx, string name, string role, int age);

    Rectangle {
        id: teamMembers
        width: parent.width - 20
        height: parent.height - 20
        anchors.centerIn: parent

        ListView {
            id: membersView
            model: MemberModel {
                members: memberList
            }
            delegate: memberDelegate
            anchors.fill: parent
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
                        Utils.getRoleColor(model.role)
                    }
                    border.color: "black"
                    border.width: 1
                }

                Text {
                    x: parent.height + 10
                    anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 15
                    text: model.name
                }

                Text {
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 15
                    text: model.age
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        membersView.currentIndex = index;
                        selectMember(index, model.name, model.role, model.age);
                    }
                }

                onFocusChanged: {
                    if (focus)
                        bg.opacity = 0.5
                    else
                        bg.opacity = 0.0
                }
            }
        }
    }
}


