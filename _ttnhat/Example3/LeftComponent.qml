import QtQuick 2.0

Rectangle {
    color: "red"
    property alias leftText : leftTextInput.text
    signal btnLeftClicked()
    TextInput{
        id: leftTextInput
        text: qsTr("Text Input 1")
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 80
        color: "white"

    }
    Rectangle {
        color: "white"
        width: 200
        height: 25
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 50
        MouseArea {
            id : btnLeft
            anchors.fill: parent
            Text {
                text: qsTr("Pick")
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
            onClicked: {
                btnLeftClicked()
            }
        }
    }
}
