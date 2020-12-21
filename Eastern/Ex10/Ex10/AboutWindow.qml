import QtQuick 2.0
import QtQuick.Controls 1.4

ApplicationWindow {
    id: aboutWindow

    visible: true
    width: 300
    height: 300
    title: qsTr("About")

    Text {
        height: parent.height *2/3
        width: parent.height *2/3
        anchors.centerIn: parent
        text: "Team managerment app version 1.0"
        wrapMode: Text.WordWrap
        font.pixelSize: 15
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
}
