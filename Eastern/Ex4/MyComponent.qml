import QtQuick 2.0

Rectangle
{
    property string textButton: ""

    signal clickButton()

    Text {
        text: textButton
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
