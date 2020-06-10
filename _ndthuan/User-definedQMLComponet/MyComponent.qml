import QtQuick 2.0

Item {
    id: root
    property alias color: background.color
    property alias text: textInput.text
    signal textInputChanged(string strRight)
    signal clicked()
    Rectangle {
        id: background
        anchors.fill: parent
        color: "green"
        TextInput {
            id: textInput
            text: "Text input 2"
            width: parent.width
            anchors.leftMargin: 20
            anchors.rightMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 30
            horizontalAlignment: TextInput.AlignHCenter
            verticalAlignment: TextInput.AlignVCenter
            onTextChanged: {
                root.textInputChanged(text)
            }
        }

        Rectangle {
            id: button
            color: "white"
            width: parent.width
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 20
            anchors.rightMargin: 20
            height: 20
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
                    root.clicked()
                }
            }
        }
    }
}
