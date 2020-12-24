import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 1.4
import MyEnum 1.0

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Have Fun With Boxes")

    property var component: Qt.createComponent("MyShape.qml")

    function insertToGrid(shapeType, shapeNumber, shapeColor) {
        component.createObject(sidebarGrid,
            {shapeType: myShape.shapeType, shapeColor: myShape.shapeColor, shapeNumber: myShape.shapeNumber})
    }

    Item {
        id: itemRoot

        width: parent.width * 14/15
        height: parent.height * 14/15
        anchors.centerIn: parent

        Item {
            id: itemText

            width: parent.width
            height: parent.height * 1/20

            Text {
                anchors.fill: parent
                text: "My Boxes"
            }
        }

        Rectangle {
            id: rectGrid

            width: parent.width * 12/17
            height: parent.height * 19/20
            anchors.top: itemText.bottom

            border.color: "black"

            Flickable {
                id: flickItem

                width: parent.width * 19/20
                height: parent.height * 19/20
                contentHeight: 100 * parseInt(sidebarGrid.children.length/sidebarGrid.columns +
                    (sidebarGrid.children.length%sidebarGrid.columns == 0 ? 0 : 1))
                anchors.centerIn: parent
                clip: true
                contentY: (flickItem.contentHeight > flickItem.height) ? flickItem.contentHeight - flickItem.height : 0

                Grid {
                    objectName: "sidebarView"
                    id: sidebarGrid

                    anchors.fill: parent
                    spacing: 0
                    columns: parseInt(parent.width /100)
                    add: Transition {
                        NumberAnimation { properties: "x,y"; from: 0; duration: 300 }
                    }
                }
            }
        }

        Item {
            width: parent.width * 4/17
            height: parent.height * 19/20

            anchors.right: itemRoot.right
            anchors.top: itemText.bottom

            ComboBox {
                id: comboBox

                width: parent.width
                height: parent.height * 1/10
                model: ListModel {
                    ListElement { text: "BOX" }
                    ListElement { text: "CIRCLE" }
                    ListElement { text: "TRIANGLE" }
                }
                currentIndex: myShape.shapeType
                onCurrentIndexChanged: {
                    myShape.shapeType = currentIndex;
                }
            }

            MyShape {
                id: myShape

                width: parent.width
                height: parent.width
                y: comboBox.y + comboBox.height + 10
            }



            Button {
                id: buttonGen

                property int count: 0

                width: parent.width
                height: parent.height / 10
                y: myShape.y + myShape.height + 10
                text: "GENERATE"

                onClicked: {
                    timer.start()
                }

                Timer {
                    id: timer

                    interval: 100
                    running: false
                    onTriggered: {
                        myShape.genShape()
                        if (buttonGen.count < 10) {
                            buttonGen.count++
                            timer.start()
                            buttonGen.enabled = false
                        }
                        else {
                            buttonGen.count = 0
                            buttonGen.enabled = true
                        }
                    }
                }
            }

            MyButton {
                id: buttonCpp

                width: parent.width
                height: parent.height / 10
                y: buttonGen.y + buttonGen.height + 10
                buttonText: "Add by Cpp"

                onClickButton: {
                    MyShapeCpp.addShape(myShape.shapeType, myShape.shapeNumber, myShape.shapeColor)
                }
            }

            MyButton {
                id: buttonQml

                property int count: 0

                width: parent.width
                height: parent.height / 10
                y: buttonCpp.y + buttonCpp.height + 10
                buttonText: "Add by Qml"

                onClickButton: {
                    insertToGrid(myShape.shapeType, myShape.shapeNumber, myShape.shapeColor)
                }
            }

            MyButton {
                id: buttonClear

                property int count: 0

                width: parent.width
                height: parent.height / 10
                y: buttonQml.y + buttonQml.height + 10
                buttonText: "CLEAR"

                onClickButton: {
                    for(var i = 0; i < sidebarGrid.children.length ; i++) {
                        sidebarGrid.children[i].destroy();
                    }
                }
            }
        }
    }
}
