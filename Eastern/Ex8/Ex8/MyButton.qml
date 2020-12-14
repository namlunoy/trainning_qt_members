import QtQuick 2.0

Rectangle {
    property string buttonText: ""

    signal clickButton()

    color: "#c0bbbb"

    Text {
        anchors.fill: parent
        text: buttonText
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 15
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            clickButton()
        }
    }
}
