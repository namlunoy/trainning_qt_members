import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    Text {
        id: test
        text: MyMessage.author
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        Component.onCompleted: {
            MyMessage.set("Hello clark")
        }
    }

    TextField {
        id: txtInput
        text: "write to here"
        anchors.centerIn: parent
    }

    Button {
        id: reset
        text: "reset"
        x: 100
        y: 150

        onClicked: {
            MyMessage.reset()
        }
    }

    Button {
        id: set
        text: "set"
        x: 300
        y: 150
        onClicked: {
            MyMessage.set(txtInput.text)
        }
    }

    Connections {
        target: MyMessage
        onShowText: {
            console.log("Receive showText signal")
        }
    }
}
