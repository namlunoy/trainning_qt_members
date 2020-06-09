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
                    numText.text = touchPadMouseA.counter.toString()
                }
            }
        }

        MouseArea {
            id: touchPadMouseA
            anchors.fill: parent
            property int counter: 0
            property double startX: 0
            property double lastCurX: 0
            property int dir: 0
            property int curX: 0
            property bool changedDir: false

            onPressed: {
                startX = mouse.x; curX = mouse.x
                lastCurX = mouse.x; changedDir = true
            }

            onPositionChanged: {
                curX = mouse.x

                console.log("start x: " + startX + "    lastCur  x: " + lastCurX   + "    current x: " + curX)
                // check direction
                if(curX > lastCurX)
                {
                    if(dir == 1) // previous to right
                    {
                        startX = curX
                        changedDir = true
                    }
                    dir = 0
                }
                else
                {
                    if(dir == 0) // previous to left
                    {
                        startX = curX
                        changedDir = true
                    }
                    dir = 1
                }

                lastCurX = curX


                if(curX > startX + 50 && dir == 0)
                {
                    if(changedDir)
                    {
                        counter++
                        changedDir = false
                    }
                }

                if(curX < startX - 50 && dir == 1)
                {
                    if(changedDir)
                    {
                        counter--
                        changedDir = false
                    }
                }
            }

            onCounterChanged: {
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
