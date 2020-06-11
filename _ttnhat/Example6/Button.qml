import QtQuick 2.0

Rectangle{
    property var bgImg: ['qrc:/button/btn_normal', 'qrc:/button/btn_pressed', 'qrc:/button/btn_selected']
    state: "normal"
    id : rectBtn
    Image {
        id : imgBg
        anchors.fill: parent
    }
    Text {
        id: textCenter
        anchors.centerIn: parent
    }
    MouseArea{
       anchors.fill: parent
       onPressed :{
           if (rectBtn.state === 'normal') {
               rectBtn.state = 'pressed'
               btnTimer.start()
           }
           else if (rectBtn.state === 'selected') {
               rectBtn.state = 'normal'
           }
       }
       onReleased: {
           if (rectBtn.state !== 'selected') {
               btnTimer.stop()
               rectBtn.state = 'normal'
           }
       }
    }
    states : [
        State {
            name: "normal"
            PropertyChanges {
                target: imgBg
                source : bgImg[0]
            }
            PropertyChanges {
                target: textCenter
                text : "Normal"
            }
        },
        State {
            name: "pressed"
            PropertyChanges {
                target: imgBg
                source : bgImg[1]
            }
            PropertyChanges {
                target: textCenter
                text : "Pressed"
            }
        },
        State {
            name : "selected"
            PropertyChanges {
                target: imgBg
                source : bgImg[2]
            }
            PropertyChanges {
                target: textCenter
                text : "Selected"
            }
        }

    ]

    Timer {
        id : btnTimer
        interval: 1000
        running: false
        repeat: false
        onTriggered: {
            if (rectBtn.state === 'pressed')
            {
                rectBtn.state = 'selected'
            }
        }
    }

}
