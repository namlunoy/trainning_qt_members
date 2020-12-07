import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    MouseArea
    {
        id: touch_pad

        property int count : 0
        property int stepLength: 50
        property int startX: 0
        property int delta: 0

        anchors.fill: parent

        onMouseXChanged:
        {
            if(startX == 0)
            {
                startX = mouseX
            }
            else
            {
                delta = mouseX - startX

                if (Math.abs(delta) > stepLength)
                {
                    if (delta > 0)
                        count++
                    else
                        count--

                    startX = mouseX
                }
            }
        }

        onReleased:
        {
            startX = 0
            delta = 0
        }
    }

    Text
    {
        anchors.centerIn: parent
        text: touch_pad.count.toString()
        font.pixelSize: 100
    }

    Text
    {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        text: "swipe left or right to change the value"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
}
