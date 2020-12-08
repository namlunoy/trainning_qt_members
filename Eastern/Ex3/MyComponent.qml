import QtQuick 2.12


Rectangle {
    signal requestText();

    function getText ()
    {
        return textIn.text;
    }

    function setText (txt)
    {
        textIn.text = txt;
    }

    TextInput
    {
        id: textIn
        height: parent.height / 10
        color: "white"
        width: parent.width
        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height / 3
        text: "Text Input 1"
        cursorVisible: true
        horizontalAlignment: Text.AlignHCenter
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
                requestText();
            }
        }
    }
}
