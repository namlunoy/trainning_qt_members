import QtQuick 2.13
import QtQuick.Window 2.13

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    Item {
        id: leftItem
        property alias text: textInput.text
        anchors.top: parent.top
        anchors.left: parent.left
        width: parent.width/2
        height: parent.height - 50
        signal textInputChanged(string strLeft)
        Rectangle {
            id: background
            anchors.fill: parent
            color: "orange"
            TextInput {
                id: textInput
                text: "Text input 1"
                width: parent.width
                anchors.leftMargin: 20
                anchors.rightMargin: 20
                anchors.top: parent.top
                anchors.topMargin: 30
                horizontalAlignment: TextInput.AlignHCenter
                verticalAlignment: TextInput.AlignVCenter
                onTextChanged: {
                    leftItem.textInputChanged(text)
                }
            }

            Rectangle {
                id: button
                color: "white"
                width: parent.width
                height: 20
                anchors.leftMargin: 20
                anchors.rightMargin: 20
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 30
                Text {
                    text: qsTr("Pick")
                    anchors.centerIn: parent
                }
                MouseArea {
                    anchors.fill: parent
                    onPressed: {
                        button.color = "gray"
                    }
                    onReleased: {
                        button.color = "white"
                    }
                    onClicked: {
                        leftItem.text = rightItem.text
                    }
                }
            }
        }
    }

    MyComponent {
        id: rightItem
        color: "green"
        anchors.top: parent.top
        anchors.right: parent.right
        height: parent.height - 50
        anchors.left: leftItem.right
        x: parent.width/2
        onClicked: {
            text = leftItem.text
        }
    }

    Rectangle {
        id: swapButton
        anchors.leftMargin: 20
        anchors.rightMargin: 20
        anchors.left: parent.left
        anchors.right: parent.right
        width: parent.width
        anchors.top: leftItem.bottom
        height: 20
        Text {
            text: qsTr("Swap")
            anchors.centerIn: parent
        }
        border.width: 1

        MouseArea {
            anchors.fill: parent
            onPressed: {
                swapButton.color = "gray"
            }
            onReleased: {
                swapButton.color = "white"
            }

            onClicked: {
                var tempStr = disText.str1
                leftItem.text = disText.str2
                rightItem.text = tempStr
            }
        }
    }

    Text {
        id: disText
        property string str1: leftItem.text
        property string str2: rightItem.text
        width: parent.width
        anchors.bottom: parent.bottom
        anchors.top: swapButton.bottom
        text: str1 + ' ' + str2
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        Connections {
            target: leftItem
            onTextInputChanged: {
                disText.str1 = strLeft
            }
        }

        Connections {
            target: rightItem
            onTextInputChanged: {
                disText.str2 = strRight
            }
        }
    }
}
