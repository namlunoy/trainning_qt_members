import QtQuick 2.0
import QtQuick.Controls 2.12

Rectangle {
    signal myTextChanged()
    signal myButtonClicked()

    TextInput {
        id: txtInput
        text: "Text input 1"
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 30

        onTextChanged: {
            myTextChanged()
        }
    }

    Button {
        text: "Pick"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        onClicked: {
            myButtonClicked()
        }
    }

    function getText() {
        return txtInput.text
    }

    function setText(txt) {
        txtInput.text = txt
    }
}
