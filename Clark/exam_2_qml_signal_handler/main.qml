import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello Connected Car!!!")

    MouseArea {
        id: touchpad
        anchors.fill: parent

        property int counter: 0
        property int delta: 0
        property int startX: 0
        property int endX: 0
        property int x_step: 50

        signal somethingChanged(int val)

        onPressed: {
            startX = mouseX;
            endX = mouseX;
        }

        onReleased: {
            endX = mouseX
            delta = Math.abs(startX - endX);

            if (delta > x_step) {
                if (startX < endX) {
                    counter++
                } else {
                    counter--;
                }

                // emit signal
                somethingChanged(counter)
            }
        }

        onCounterChanged: {
            console.log("user-defined signal handler for property Counter, called internally")
        }
    }

    Text {
        id: counter_display
        text: qsTr("0")
        anchors.centerIn: parent
        font.pixelSize: 50
        color: "red"

        Connections {
            target: touchpad
//            onCounterChanged: {
//                console.log("user-defined signal handler for property Counter, called from Text component");
//                counter_display.text = touchpad.counter.toString();
//            }

            onSomethingChanged: {
                console.log("user-defined signal handler for property Counter, called from Text component");
                counter_display.text = touchpad.counter.toString();
            }
        }
    }

    Text {
        id: hint
        text: qsTr("swipe to right or left to change the number")
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
