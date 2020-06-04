import QtQuick 2.13
import QtQuick.Window 2.13

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Exam 1")

    Rectangle {
        id: touchPad
        property int count: 1
        property double pX: 0
        property double pY: 0
        property double rX: 0
        property double rY: 0

        function checkSwipe(pX, pY, rX, rY) {
            if (rX > pX + 50)
            {
                touchPad.count++
            }
            else if (rX < pX - 50)
            {
                touchPad.count--
            }
            else
            {

            }

        }

        anchors.fill: parent

        Text {
            id: numText
            text: touchPad.count
            anchors.centerIn: parent
            font.pixelSize: 40
        }

        MouseArea {
            anchors.fill: parent
            onPressed: {
                touchPad.pX = mouse.x; touchPad.pY = mouse.y
            }

            onReleased: {
                touchPad.rX = mouse.x; touchPad.rY = mouse.y
                touchPad.checkSwipe(touchPad.pX, touchPad.pY, touchPad.rX, touchPad.rY)
            }
        }

        Rectangle{
            height: 30
            width: parent.width
            anchors.bottom: parent.bottom
            Text {
                text: qsTr("swipe left or right to change the value")
                anchors.centerIn: parent
            }
        }

    }


}
