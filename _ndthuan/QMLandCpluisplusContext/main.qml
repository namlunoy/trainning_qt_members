import QtQuick 2.13
import QtQuick.Window 2.13

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("qml and c++ context")

    function toFomatedString(num){
        var s = ""
        s = num.toString()

        if(s.length === 1)
        {
            s = '0' + s
        }

        return s
    }

    Rectangle {
        id: resetButton
        width: 50
        height: 50
        border.width: 1
        anchors.bottom: clockBackgroud.top
        anchors.bottomMargin: 30
        x:  parent.width/2 - width

        Text {
            text: qsTr("Reset")
            anchors.centerIn: parent
            font.pixelSize: 20
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                TimerTest.second = 0; TimerTest.minute = 0
                TimerTest.stopTimer()
            }
        }
    }

    Rectangle {
        id: setButton
        anchors.top: resetButton.top
        anchors.left: resetButton.right
        anchors.leftMargin: 10
        width: 50
        height: 50
        border.width: 1
        Text {
            text: qsTr("Set")
            anchors.centerIn: parent
            font.pixelSize: 20
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                TimerTest.setTimer()
            }
        }
    }

    Rectangle{
        id: clockBackgroud
        width: 200
        height: 100
        y: parent.height/2 - height/2
        x: parent.width/2 - width/2
        Rectangle {
            id: minRec
            height: parent.height
            width: parent.width/2
            anchors.left: parent.left
            border.width: 1
            Text {
                id: minText
                text: toFomatedString(TimerTest.minute) // using notify, whenever TimerTest.minute is changed, text will update via signal
                anchors.centerIn: parent
                font.pixelSize: 30
            }

        }

        Rectangle {
            id: secRec
            anchors.left: minRec.right
            anchors.right: parent.right
            height: parent.height
            border.width: 1
            Text {
                id: secText
                text: toFomatedString(TimerTest.second) // using notify, whenever TimerTest.second is changed, text will update via signal
                anchors.centerIn: parent
                font.pixelSize: 30
            }

        }
    }

    Rectangle {
        id: incMinButton
        border.width: 1
        width: minRec.width
        height: 20
        anchors.left: clockBackgroud.left
        anchors.bottom: clockBackgroud.top
        anchors.bottomMargin: 5
        Text {
            text: qsTr("+")
            anchors.centerIn: parent
            font.pixelSize: 20
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                TimerTest.minute++;
                if(TimerTest.minute == 60)
                    TimerTest.minute = 0
            }
        }
    }

    Rectangle {
        id: decMinButton
        border.width: 1
        width: minRec.width
        height: 20
        anchors.left: clockBackgroud.left
        anchors.top: clockBackgroud.bottom
        anchors.topMargin: 5
        Text {
            text: qsTr("-")
            anchors.centerIn: parent
            font.pixelSize: 20
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                TimerTest.minute--;
                if(TimerTest.minute < 0)
                    TimerTest.minute = 59
            }
        }
    }

    Rectangle {
        id: incSecButton
        border.width: 1
        width: secRec.width
        height: 20
        anchors.right: clockBackgroud.right
        anchors.bottom: clockBackgroud.top
        anchors.bottomMargin: 5
        Text {
            text: qsTr("+")
            anchors.centerIn: parent
            font.pixelSize: 20
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                TimerTest.second++
                if(TimerTest.second == 60)
                    TimerTest.second = 0
            }
        }
    }

    Rectangle {
        id: decSecButton
        border.width: 1
        width: secRec.width
        height: 20
        anchors.right: clockBackgroud.right
        anchors.top: clockBackgroud.bottom
        anchors.topMargin: 5
        Text {
            text: qsTr("-")
            anchors.centerIn: parent
            font.pixelSize: 20
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                TimerTest.second--
                if(TimerTest.second < 0)
                    TimerTest.second = 59
            }
        }
    }
}
