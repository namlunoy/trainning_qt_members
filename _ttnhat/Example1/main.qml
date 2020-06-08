import QtQuick 2.12
import QtQuick.Window 2.12


Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")
    MouseArea{
        id : mouseArea
        anchors.fill: parent
        property int lastX: 0
        property int stepX : 100
        property int direction: 0
        property int delta: 0
        property bool isUpChanged: false
        property bool isDownChanged: false
        onPressed: {
            lastX = mouse.x
            isUpChanged = false
            isDownChanged = false
        }
        onPositionChanged: {
            var currentX = mouse.x
            if (currentX > lastX)
            {
                direction = 1 //swipe right
                delta = currentX - lastX
            }
            else
            {
                direction = -1 //swipe left
                delta = lastX - currentX
            }

            if (delta >=50) {
               if (direction == 1) {
                   if (!isUpChanged)
                   {
                       textCount.count++
                       isUpChanged = true
                       isDownChanged = false
                   }
               }
               else
               {
                   if (!isDownChanged)
                   {
                       textCount.count--
                       isDownChanged = true
                       isUpChanged = false
                   }
               }
               lastX = currentX
            }
        }
    }

    Text{
        property int count: 0
        id : textCount
        text: count
        anchors.centerIn: parent
        font.pixelSize: 50
    }
    Text {
        text: qsTr("swipe right or left to change value")
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
