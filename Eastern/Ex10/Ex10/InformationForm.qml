import QtQuick 2.0
import QtQuick.Controls 2.5
import "MyColor.js" as MyJS

Item {
    property string memberName: ""
    property string memberAge: ""
    property int roleIndex: -1
    property bool isAdd: false
    property int memberIndex: -1

    signal addMember()
    signal updateMember()

    Item {
        height: loader.height
        width: loader.width
        Text {
            id: nameText

            height: parent.height *1/4
            width: parent.width *1/4
            text: "Name:"
            font.pixelSize: parent.height /16
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        TextField {
            id: nameValue

            height: parent.height *1/4
            width: parent.width *3/4
            font.pixelSize: parent.height /16
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.left: nameText.right
            text: memberName
            placeholderText: "Insert name"
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

        TextField {
            id: ageValue

            height: parent.height *1/4
            width: parent.width *3/4
            font.pixelSize: parent.height /16
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.top: nameText.bottom
            anchors.left: ageText.right
            text: memberAge
            placeholderText: "Insert age"
            validator: IntValidator {bottom: 0; top: 100}
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
                ListElement { elementText: "BA"; elementColor: "red" }
                ListElement { elementText: "Tester"; elementColor: "green" }
                ListElement { elementText: "Developer"; elementColor: "blue" }
                ListElement { elementText: "Team Leader"; elementColor: "yellow" }
            }

            delegate: Rectangle {
                height: comboBox.height
                width: comboBox.width
                color: elementColor

                Text {
                    anchors.fill: parent
                    font.bold: true
                    text: elementText
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: comboBox.height *1/4
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        comboBox.currentIndex = index
                        comboBox.popup.close()
                    }
                }
            }

            currentIndex: roleIndex
            background: Rectangle
            {
                anchors.fill: parent
                border.color: "black"
                border.width: 1
                color: MyJS.getColorFromIndex(comboBox.currentIndex)
            }

            font.bold: true
            font.pixelSize: comboBox.height *1/4
            displayText: MyJS.getRoleFromIndex(comboBox.currentIndex)
        }

        Loader {
            id: buttonLoader

            height: parent.height *1/4
            width: parent.width
            anchors.top: comboBox.bottom
            sourceComponent: (isAdd)? oneButtonComponent : twoButtonComponent
        }
    }

    Component {
        id: twoButtonComponent

        Item {
            anchors.fill: parent

            Item {
                id: updateItem

                height: parent.height
                width: parent.width *2/4

                Button {
                    height: parent.height *3/4
                    width: parent.width *3/4
                    anchors.centerIn: parent
                    text: "UPDATE"
                    onClicked: {
                        MemberListModel.updateMember(memberIndex, nameValue.text, ageValue.text, comboBox.displayText)
                        updateMember()
                    }
                }
            }

            Item {
                height: parent.height
                width: parent.width *2/4
                anchors.left: updateItem.right

                Button {
                    height: parent.height *3/4
                    width: parent.width *3/4
                    anchors.centerIn: parent
                    text: "DELETE"
                    onClicked: {
                        MemberListModel.deleteMember(memberIndex)
                        loader.sourceComponent = null
                    }
                }
            }
        }
    }

    Component {
        id: oneButtonComponent

        Item {
            anchors.fill: parent

            Button {
                id: addButton

                height: parent.height *3/4
                width: parent.width *3/8
                anchors.centerIn: parent
                text: "ADD"
                onClicked: {
                    MemberListModel.addMember(nameValue.text, ageValue.text, comboBox.displayText)
                    addMember()
                }
            }
        }
    }

    onRoleIndexChanged: {
        comboBox.currentIndex = roleIndex
    }
}
