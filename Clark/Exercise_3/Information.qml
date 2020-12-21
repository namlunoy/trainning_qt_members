import QtQuick 2.0
import QtQuick.Controls 2.12

import MemberList 1.0

import "Utils.js" as Utils

Rectangle {
    id: rootInfor
    y: 20
    width: 270
    height:  340
    border.color: "lightgrey"
    border.width: 1
    anchors.horizontalCenter: parent.horizontalCenter
    property string memberName: "Default Name"
    property int memberAge: 99
    property int memberRole: 0
    property int idx: 0
    property bool isAdd: false;

    Rectangle {
        id: infor
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
                text: rootInfor.memberName;
                anchors.leftMargin: 0
                anchors.left: parent.left
                placeholderText: "Enter name"
                font.pixelSize: 12

                onTextChanged: {
                    rootInfor.memberName = this.text;
                }
            }
            TextField {
                width: 140
                height: 40
                y: 55;
                text: rootInfor.memberAge.toString();
                anchors.left: parent.left
                placeholderText: "Enter age"
                font.pixelSize: 12

                onTextChanged: {
                    if (this.text !== "") // Avoid negative value when text is null
                        rootInfor.memberAge = parseInt(this.text);
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
                        color: Utils.getRoleColor(modelData)
                    }
                }

                background: Rectangle
                {
                    width: 140
                    height: 40
                    border.color: "black"
                    border.width: 1
                    color: {
                        Utils.getRoleColor(roleSelect.currentIndex)
                    }
                }

                onCurrentIndexChanged: {
                    rootInfor.memberRole = roleSelect.currentIndex;
                }

                font.pixelSize: 12
                font.bold: true
                currentIndex: rootInfor.memberRole
            }
        }
    }

    Rectangle {
        y: 240
        height: delBtn.height
        width: parent.width - 40
        anchors.horizontalCenter: parent.horizontalCenter

        Button {
            id: updateBtn
            text: "UPDATE"
            anchors.left: parent.left

            onClicked: {
                memberList.setItemAt(idx, rootInfor.memberName, rootInfor.memberRole, rootInfor.memberAge);
            }
        }

        Button {
            id: delBtn
            text: "DELETE"
            anchors.right: parent.right
            onClicked: {
                memberList.removeCompletedItems(idx)
            }
        }

        Button {
            id: addBtn
            text: "ADD"
            anchors.horizontalCenter: parent.horizontalCenter;
            onClicked: {
                memberList.appendItem(rootInfor.memberName, rootInfor.memberRole, rootInfor.memberAge);
            }
        }

        Component.onCompleted: {
            if (isAdd) {
                addBtn.visible = true;
                delBtn.visible = false;
                updateBtn.visible = false;
            }
            else {
                addBtn.visible = false;
                delBtn.visible = true;
                updateBtn.visible = true;
            }
        }
    }
}

