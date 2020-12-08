import QtQuick 2.0

Rectangle
{
    property string textButon: ""

    signal handleButton()

    Text {
        text: textButon
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.fill: parent
        font.pixelSize: 60
    }

    MouseArea
    {
        anchors.fill: parent
    }
}
