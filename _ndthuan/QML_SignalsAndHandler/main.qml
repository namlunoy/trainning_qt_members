import QtQuick 2.13
import QtQuick.Window 2.13

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Exam 2")

    Rectangle {
        id: touchPad



        anchors.fill: parent

        Text {
            id: numText
            text: "0"
            anchors.centerIn: parent
            font.pixelSize: 40
            Connections {
                target: touchPadMouseA
                onCounterChanged: {
                    console.log("user-defined signal handler for property Counter, called from Text component");
                    numText.text = touchPadMouseA.counter.toString()
                }
            }
        }

        MouseArea {
            id: touchPadMouseA
            anchors.fill: parent
            property int counter: 0
            property double pX: 0
            property double pY: 0
            property double rX: 0
            property double rY: 0
            onPressed: {
                pX = mouse.x; pY = mouse.y
            }

            onReleased: {
                rX = mouse.x; rY = mouse.y
                if (rX > pX + 50)
                {
                    counter++
                }
                else if (rX < pX - 50)
                {
                    counter--
                }
                else
                {

                }
            }
            onCounterChanged: {
                console.log("user-defined signal handler for property Counter, called internally");
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
