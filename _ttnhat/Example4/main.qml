import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Example4")

    Text{
        id : add
        text: '+'
        font.pixelSize: 50
        anchors.left: parent.left
        anchors.leftMargin: 50
        MouseArea {
            anchors.fill: parent
            onClicked: {
                CountNumber.increaseCount()
            }
        }
    }
    Text {
        id : minus
        text: qsTr("-")
        font.pixelSize: 50
        anchors.left: add.right
         anchors.leftMargin: 50
        MouseArea{
            anchors.fill: parent
            onClicked: {
                CountNumber.decreaseCount()
            }
        }
    }
    Text {
        id : set
        text: qsTr("Set")
        font.pixelSize: 50
        anchors.right: reset.left
        anchors.rightMargin: 50
        MouseArea{
            anchors.fill: parent
            onClicked: {
                CountNumber.setCountBtn(100)
            }
        }
    }
    Text {
        id : reset
        text: qsTr("Reset")
        font.pixelSize: 50
        anchors.right: parent.right
        anchors.rightMargin: 50
        MouseArea{
            anchors.fill: parent
            onClicked: {
                CountNumber.resetCountBtn()
            }
        }
    }
    Text {
        id: count
        text: CountNumber.count
        anchors.centerIn: parent
        font.pixelSize: 50
        Connections {
            target: CountNumber
            onCountChanged : {
                console.log("Signal send to QML from C++")
            }
        }
    }
}
