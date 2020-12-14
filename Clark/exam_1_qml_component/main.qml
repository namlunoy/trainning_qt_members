import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    visible: true
    width: 640
    height: 480

    MouseArea {
        id: touchpad
        anchors.fill: parent

        property int counter: 0
        property int startX: 0
        property int endX: 0
        property int delta: 0
        property int x_step: 50

        onPressed: {
            startX = mouseX;
            endX = mouseX;
        }

        onReleased: {
            endX = mouseX;
            delta = Math.abs(startX - endX)

            if (delta > x_step) {
                if (startX < endX) {
                    counter++;
                } else {
                    counter--;
                }
            }
        }
    }

    Text {
        id: display_counter
        text: qsTr(touchpad.counter.toString())
        font.pixelSize: 50
        anchors.centerIn: parent
        color: "red"
    }

    Text {
        id: hint
        text: qsTr("swipe to the left or to the right to change the value")
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
