import QtQuick 2.0

Rectangle {
    id: root
    height: 50
    width: 100
    state: "normalState"
    property var images: ["qrc:/norBtn", "qrc:/prsBtn", "qrc:/selBtn"]

    Image {
        id: bgImage
        anchors.fill: parent
    }

    Text {
        id: txt
        font.pointSize: 16
        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: "white"
    }

    states: [
        State {
            name: "normalState"
            PropertyChanges { target: bgImage; source: images[0] }
            PropertyChanges { target: txt; text: "Normal" }
        },
        State {
            name: "pressState"
            PropertyChanges { target: bgImage; source: images[1] }
            PropertyChanges { target: txt; text: "Pressed" }
        },
        State {
            name: "selectState"
            PropertyChanges { target: bgImage; source: images[2] }
            PropertyChanges { target: txt; text: "Selected" }
        }
    ]

    Timer {
        id: timer
        interval: 1000
        running: false
        repeat: false

        onTriggered: {
            if (root.state == "pressState") {
                root.state = "selectState";
            }
        }
    }

    MouseArea {
        anchors.fill: parent

        onPressed: {
            if (root.state == "normalState") {
                root.state = "pressState";
                timer.start();
            }
            else if (root.state == "selectState") {
                root.state = "normalState";
            }
        }

        onReleased: {
            if (root.state == "pressState") {
                root.state = "normalState";
                timer.stop();
            }
        }
    }
}
