import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    MouseArea
    {
        id: touchPad

        signal somethingChanged(var something)

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

        onCountChanged:
        {
            somethingChanged(count);
        }
    }

    Text
    {
        id: numberText

        text: "0"
        anchors.centerIn: parent
        font.pixelSize: 100

        Connections
        {
            target: touchPad
            onCountChanged:
            {
                numberText.text = touchPad.count.toString()
            }
        }
    }

    Text
    {
        id: noteText

        property string str: "swipe left or right to change the value"

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        text: str
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        Connections
        {
            target: touchPad
            onSomethingChanged:
            {
                noteText.text = "VALUE CHANGE TO " + something.toString()
                noteText.color = "red"
            }

            onReleased:
            {
                noteText.color = "black"
                noteText.text = noteText.str
            }
        }
    }
}
