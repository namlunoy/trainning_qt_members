import QtQuick 2.0

Rectangle {
    width: 100
    height: 100
    radius: 50

    property string insideText: "white"

    Text {
        text: qsTr(insideText)
        font.bold: true
        font.pointSize: 20
        anchors.centerIn: parent
    }

    border.color: "black"
    border.width: 3
}
