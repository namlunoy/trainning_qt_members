import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    MyComponent {
        width: parent.width / 2
        height: parent.height * 0.75
        id: left
        color: "red"
        anchors.left: parent.left

        onMyTextChanged: {
           textDisplay.text = getText() + " " + txtInput2.text
        }

        onMyButtonClicked: {
            setText(txtInput2.text)
        }
    }
    Rectangle {
        width: parent.width / 2
        height: parent.height * 0.75
        id: right
        color: "blue"
        anchors.right: parent.right

        TextInput {
            id: txtInput2
            text: "Text input 2"
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 30

            onTextChanged: {
                textDisplay.text = left.getText() + " " + txtInput2.text;
            }
        }

        Button {
            id: bt2
            text: "Pick"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            onClicked: {
                txtInput2.text = left.getText()
            }
        }
    }

    Rectangle {
        width: parent.width
        height: parent.height * 0.25
        anchors.bottom: parent.bottom

        Button {
            id: swap
            text: "Swap"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            property string tmpStr: "";

            onClicked: {
                swap.tmpStr = left.getText();
                left.setText(txtInput2.text);
                txtInput2.text = swap.tmpStr;
            }
        }

        Text {
            id: textDisplay
            text: "Text"
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 30
        }
    }
}
