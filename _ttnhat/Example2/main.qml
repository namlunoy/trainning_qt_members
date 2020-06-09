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
        Connections{
            target: textCount
            onCountChanged : {
                console.log('Automatic generate signal when count change in external mouseArea')
            }
            onNotifyCountChanged: {
                console.log('User-defined signal notifyCount call from external MouseArea with val: ' + val)
            }
        }
    }

    Text{
        property int count: 0
        signal notifyCountChanged(int val)
        id : textCount
        text: count
        anchors.centerIn: parent
        font.pixelSize: 50
        onCountChanged: {
            console.log('Automatic generate signal when count change in internal TextCount')
            notifyCountChanged(count)
        }
        onNotifyCountChanged: {
            console.log('User-defined signal notifyCount call from internal TextCount with val: ' + val)
        }
    }
    Text {
        text: qsTr("swipe right or left to change value")
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        Connections{
            target: textCount
            onCountChanged : {
                console.log('Automatic generate signal when count change in external TextBottom')
            }
            onNotifyCountChanged: {
                console.log('User-defined signal notifyCount call from external TextBottom with val: ' + val)
            }
        }
    }
}
