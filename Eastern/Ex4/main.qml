import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    Rectangle
    {
        id: buttonTable

        width: parent.width
        height: parent.height / 5

        MyComponent
        {
            id: plusButton

            width: parent.width / 4
            height: parent.height
            textButon: "+"
        }

        MyComponent
        {
            id: subButton

            width: parent.width / 4
            height: parent.height
            anchors.left: plusButton.right
            textButon: "-"
        }

        MyComponent
        {
            id: resetButton

            width: parent.width / 4
            height: parent.height
            textButon: "Reset"
            anchors.left: subButton.right
        }

        MyComponent
        {
            id: setButton

            width: parent.width / 4
            height: parent.height
            textButon: "Set"
            anchors.left: resetButton.right
        }
    }

    Rectangle
    {
        width: parent.width
        height: parent.height * 4/5
        anchors.top: buttonTable.bottom

        Rectangle
        {
            width: parent.width / 5
            height: parent.height / 5
            anchors.centerIn: parent

            Text {
                anchors.fill: parent
                text: MyClass.val
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 60
            }
        }
    }
}
