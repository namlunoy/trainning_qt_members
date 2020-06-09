import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")
    LeftComponent {
        id : leftComp
        onBtnLeftClicked: {
            leftComp.leftText = rightTextInput.text
        }
        height: parent.height *0.7
        width: parent.width *0.5
    }
    Rectangle{
        height: parent.height * 0.7
        width: parent.width * 0.5
        anchors.left: leftComp.right
        color:"blue"
        TextInput{
            id: rightTextInput
            text: qsTr("Text Input 2")
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 80
            color : "white"
        }
        Rectangle {
            color: "white"
            width: 200
            height: 25
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 50
            MouseArea {
                id : btnRight
                anchors.fill: parent
                Text {
                    text: qsTr("Pick")
                    anchors.centerIn: parent
                }
                onClicked: {
                    rightTextInput.text = leftComp.leftText
                }
            }
        }
    }
    Rectangle{
        width: parent.width
        height: parent.height * 0.3
        anchors.top: leftComp.bottom

        Rectangle {
            id : rectSwapBtn
            color: "green"
            width: 100
            height: 25
            anchors.top: parent.top
            anchors.topMargin: 40
            anchors.horizontalCenter: parent.horizontalCenter
            MouseArea{
                id : btnSwap
                anchors.fill: parent
                Text {
                    anchors.centerIn: parent
                    text: qsTr("Swap")
                }
                onClicked: {
//                    var tempStr = leftComp.leftText
//                    leftComp.leftText = rightTextInput.text
//                    rightTextInput.text = tempStr
                      [leftComp.leftText, rightTextInput.text] = [rightTextInput.text, leftComp.leftText]
                }
            }
        }
        Text {
            id: resultText
            text:  leftComp.leftText + ' ' + rightTextInput.text
            anchors.top: rectSwapBtn.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 10
        }
    }
}

