import QtQuick 2.0
import QtQuick.Controls 2.12

Rectangle {
    y: 20
    width: 270
    height:  340
    border.color: "lightgrey"
    border.width: 1
    anchors.horizontalCenter: parent.horizontalCenter
    property bool isAdd: false
    property string memberName: "Default Name"
    property int memberAge: 99
    property int memberRole: 0

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
        x: 30
        y: 60
        width: 200
        height: 160

        Rectangle {
            width: 40
            height: 160
            anchors.left: parent.left

            Text { y: 12; text: "Name:"; anchors.right: parent.right; font.pixelSize: 12; }
            Text { y: 67; text: "Age:"; anchors.right: parent.right; font.pixelSize: 12; }
            Text { y: 122; text: "Role"; anchors.right: parent.right; font.pixelSize: 12; }
        }

        Rectangle {
            width: 140
            height: 160
            anchors.right: parent.right

            TextField {
                width: 140
                height: 40
                text: isAdd ? "Default name" : myMember.name;
                anchors.leftMargin: 0
                anchors.left: parent.left
                placeholderText: "Enter name"
                font.pixelSize: 12

                onTextChanged: {
                    memberName = this.text;
                }
            }
            TextField {
                width: 140
                height: 40
                y: 55;
                text: isAdd ? "99" : myMember.age.toString();
                anchors.left: parent.left
                placeholderText: "Enter age"
                font.pixelSize: 12

                onTextChanged: {
                    if (this.text !== "") // Avoid negative value when text is null
                        memberAge = parseInt(this.text);
                }
            }
            ComboBox {
                y: 110
                width: 140
                height: 40
                id: roleSelect
                model: [
                    "Team Leader",
                    "Developer",
                    "BA",
                    "Tester"
                ]

                delegate: ItemDelegate {
                    text: modelData
                    width: parent.width
                    background: Rectangle {
                        color: getRoleColor(modelData)
                    }
                }

                background: Rectangle
                {
                    width: 140
                    height: 40
                    border.color: "black"
                    border.width: 1
                    color: {
                        getRoleColor(roleSelect.currentIndex)
                    }
                }

                onCurrentIndexChanged: {
                    memberRole = roleSelect.currentIndex;
                }

                font.pixelSize: 12
                font.bold: true
                currentIndex: isAdd ? 0 : myMember.role
            }
        }
    }

    Loader {
        id: buttonLoader;
        y: 240
        height: 40
        width: parent.width - 40
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Component {
        id: info
        Item {
            Button {
                text: "UPDATE"
                anchors.left: parent.left
                onClicked: {
                    myMember.name = memberName;
                    myMember.age  = memberAge;
                    myMember.role = memberRole;
                    myListModel.edit();
                }
            }

            Button {
                text: "DELETE"
                anchors.right: parent.right
                onClicked: {
                    myListModel.remove();
                }
            }
        }
    }

    Component {
        id: add
        Button {
            text: "ADD"
            anchors.horizontalCenter: parent.horizontalCenter;
            onClicked: {
                myMember.name = memberName;
                myMember.age  = memberAge;
                myMember.role = memberRole;
                myListModel.append();
            }
        }
    }

    Component.onCompleted: {
        if (isAdd) {
            buttonLoader.sourceComponent = add;
        }
        else {
            buttonLoader.sourceComponent = info;
        }
    }
}

