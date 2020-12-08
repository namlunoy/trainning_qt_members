import QtQuick 2.0

Rectangle
{
    property string textButon: ""

    signal clickButton()

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
        onClicked:
        {
            clickButton()
        }
    }
}
