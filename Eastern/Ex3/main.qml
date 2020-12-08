import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    Rectangle
    {
        anchors.fill: parent

        MyComponent
        {
            id: compLeft

            width: parent.width / 2
            height: parent.height * 7/10
            anchors.left: parent.left
            color: "red"

            onRequestText:
            {
                setText(textInRight.text)
            }
        }


    }

    Rectangle {
        id: compRight

        width: parent.width / 2
        height: parent.height * 7/10
        anchors.right: parent.right
        color: "blue"

        TextInput
        {
            id: textInRight
            height: parent.height / 10
            color: "white"
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            y: parent.height / 3
            text: "Text Input 2"
            horizontalAlignment: Text.AlignHCenter
            cursorVisible: true
            wrapMode: TextInput.Wrap
        }

        Rectangle
        {
            width: parent.width * 9/10
            height: parent.height / 10
            y: parent.height * 2/3
            anchors.horizontalCenter: parent.horizontalCenter
            color: "white"

            Text
            {
                anchors.centerIn: parent
                text: "Pick"
            }

            MouseArea
            {
                anchors.fill: parent
                onClicked:
                {
                    textInRight.text = compLeft.getText()
                }
            }
        }
    }

    Rectangle
    {
        width: parent.width
        height: parent.height * 3/10
        anchors.top: compRight.bottom

        Rectangle
        {
            width: parent.width / 8
            height: parent.height / 4
            y: parent.height / 4
            anchors.horizontalCenter: parent.horizontalCenter
            color: "black"

            Text {
                anchors.fill: parent
                text: "Swap"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: "white"
            }

            MouseArea{
                anchors.fill: parent
                onClicked:
                {
                    var textTemp = compLeft.getText()
                    compLeft.setText(textInRight.text)
                    textInRight.text = textTemp
                }
            }
        }

        Text {
            width: parent.width
            height: parent.height / 4
            anchors.bottom: parent.bottom
            horizontalAlignment: Text.AlignHCenter
            wrapMode: TextInput.Wrap
            text: compLeft.getText() + " " + textInRight.text
        }
    }
}
