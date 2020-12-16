import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import "MyColor.js" as MyJS

ApplicationWindow {
    id: addWindow

    visible: true
    width: 300
    height: 300
    title: qsTr("Add member")
    Item {
        height: parent.height
        width: parent.width
        Text {
            id: nameText

            height: parent.height *1/4
            width: parent.width *1/4
            text: "Name:"
            font.pixelSize: parent.height /16
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        TextInput {
            id: nameValue

            height: parent.height *1/4
            width: parent.width *3/4
            font.pixelSize: parent.height /16
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.left: nameText.right
            text: "name"
        }

        Text {
            id: ageText

            height: parent.height *1/4
            width: parent.width *1/4
            text: "Age:"
            font.pixelSize: parent.height /16
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.top: nameText.bottom
        }

        TextInput {
            id: ageValue

            height: parent.height *1/4
            width: parent.width *3/4
            font.pixelSize: parent.height /16
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.top: nameText.bottom
            anchors.left: ageText.right
            text: "0"
        }

        Text {
            id: roleText

            height: parent.height *1/4
            width: parent.width *1/4
            text: "Role:"
            font.pixelSize: parent.height /16
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.top: ageText.bottom
        }

        ComboBox {
            id: comboBox

            height: parent.height *1/4
            width: parent.width *3/4
            anchors.top: ageText.bottom
            anchors.left: roleText.right
            model: ListModel
            {
                ListElement { text: "BA"; color: "red" }
                ListElement { text: "Tester"; color: "green" }
                ListElement { text: "Developer"; color: "blue" }
                ListElement { text: "Team Leader"; color: "green" }
            }
            style: ComboBoxStyle {
                background: Rectangle {
                    width: comboBox.width
                    height: comboBox.height
                    color: MyJS.getColorFromRole(comboBox.currentText)

                    Image {
                        width: comboBox.height /2
                        height: comboBox.height /2
                        anchors.right: parent.right
                        source: "qrc:/image/triangle.png"
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
                font.pixelSize: comboBox.height /4
            }
            currentIndex: 0
        }

        Item {
            height: parent.height *1/4
            width: parent.width
            anchors.top: comboBox.bottom

            Button {
                height: parent.height *3/4
                width: parent.width *3/8
                anchors.centerIn: parent
                text: "ADD"
                onClicked: {
                    MyMemberList.addMember(nameValue.text, ageValue.text, comboBox.currentIndex)
                    addWindow.close()
                }
            }
        }
    }
}
