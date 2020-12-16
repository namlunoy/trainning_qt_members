import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import "MyColor.js" as MyJS

Item {
    property string memberName: ""
    property string memberAge: ""
    property int roleIndex: -1

    signal deleteMember()
    signal updateMember(string name, int age, int role)

    function loadInfo(name, age, role) {
        memberName = name
        memberAge = age
        roleIndex = role
        loader.sourceComponent = inforComponent
        console.log(roleIndex)
    }

    Text {
        id: titleText

        height: parent.height /20
        width: parent.width
        font.pixelSize: text.height *2/3
        verticalAlignment: Text.AlignVCenter
        text: "Information"
        x: rect.x
    }

    Rectangle {
        id: rect

        height: parent.height *12/20
        width: parent.width * 9/10
        border.color: "black"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: titleText.bottom
        color: "transparent"

        Loader {
            id: loader

            anchors.fill: parent
        }
    }

    Component {
        id: inforComponent

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

            TextInput {
                id: nameValue

                height: parent.height *1/4
                width: parent.width *3/4
                font.pixelSize: parent.height /16
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.left: nameText.right
                text: memberName
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
                text: memberAge
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
                currentIndex: roleIndex
            }

            Item {
                height: parent.height *1/4
                width: parent.width *2/4
                anchors.top: comboBox.bottom

                Button {
                    height: parent.height *3/4
                    width: parent.width *3/4
                    anchors.centerIn: parent
                    text: "UPDATE"
                    onClicked: {
                        updateMember(nameValue.text, ageValue.text, comboBox.currentIndex)
                    }
                }
            }

            Item {
                height: parent.height *1/4
                width: parent.width *2/4
                anchors.top: comboBox.bottom
                anchors.right: comboBox.right

                Button {
                    height: parent.height *3/4
                    width: parent.width *3/4
                    anchors.centerIn: parent
                    text: "DELETE"
                    onClicked: {
                        deleteMember()
                    }
                }
            }
        }
    }

    onDeleteMember: {
        loader.sourceComponent = null
    }
}
