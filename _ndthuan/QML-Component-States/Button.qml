import QtQuick 2.0

Item {
    id: root

    property var images: ["qrc:/btn_nor", "qrc:/btn_prs", "qrc:/btn_sel"]
    Image {
        id: bgImgae
        anchors.fill: parent
    }

    Text {
        id: btnText
        font.pixelSize: 16
        color: "white"
        anchors.centerIn: parent
    }
    state: 'normal'
    states: [
        State {
            name: "normal"
            PropertyChanges {target: bgImgae; source: images[0]}
            PropertyChanges {target: btnText; text: "Normal" }
        },

        State {
            name: "pressed"
            PropertyChanges {target: bgImgae; source: images[1]}
            PropertyChanges {target: btnText; text: "Pressed" }
        },

        State {
            name: "selected"
            PropertyChanges {target: bgImgae; source: images[2]}
            PropertyChanges {target: btnText; text: "Selected" }
        }
    ]
    Timer {
        id: timer
        interval: 100; running: false; repeat: false
        onTriggered: {
            if(root.state == 'pressed'){
                root.state = 'selected'
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        onPressed: {
            root.state = 'pressed'
            timer.start()
        }

        onReleased: {
            root.state = 'normal'
        }
    }

}
