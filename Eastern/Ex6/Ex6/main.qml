import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    Item {
        id: item

        property var srcImg: ["qrc:/btn_nor", "qrc:/btn_prs", "qrc:/btn_sel"]
        property var txt: ["Normal", "Pressed", "Selected"]

        width: parent.width / 3
        height: parent.height / 3
        anchors.centerIn: parent

        Image {
            id: image

            anchors.fill: parent
            source: item.srcImg[0]
        }

        Text {
            id: txt

            anchors.fill: parent
            font.pixelSize: 50
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: item.txt[0]
            color: "white"
        }

        MouseArea {
            id: mouseArea

            anchors.fill: parent
        }

        states: [
            State {
                name: "Normal"
                when: mouseArea.released
                PropertyChanges {
                    target: image
                    source: item.srcImg[0]
                }
                PropertyChanges {
                    target: txt
                    text: item.txt[0]
                }
                PropertyChanges {
                    target: timer
                    running: false
                }
            },

            State {
                name: "Press"
                when: mouseArea.pressed
                PropertyChanges {
                    target: image
                    source: item.srcImg[1]
                }
                PropertyChanges {
                    target: txt
                    text: item.txt[1]
                }
                PropertyChanges {
                    target: timer
                    running: true
                }
            },

            State {
                name: "Select"
                PropertyChanges {
                    target: image
                    source: item.srcImg[2]
                }
                PropertyChanges {
                    target: txt
                    text: item.txt[2]
                }
            }
        ]
    }

    Timer {
        id: timer

        running: false
        interval: 1000
        onTriggered: {
            item.state = "Select"
        }
    }
}
