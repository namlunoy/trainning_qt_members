import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

import "Utils.js" as Utils

Window {
    visible: true
    width: 655
    height: 480
    title: qsTr("Have fun with boxes")

    Rectangle {
        x: 25
        y: 50
        width: 420
        height: 420
        border.color: "lightGrey"
        property int randNum: 0
        property string randColor: "white"

        Flickable {
            id: flick
            width: 400
            height: 400
            anchors.centerIn: parent

            flickableDirection: Flickable.VerticalFlick
            boundsBehavior: Flickable.DragOverBounds
            clip: true

            property int row: Math.floor(grid.children.length / 4)
            contentHeight: 100 *  ((grid.children.length % 4 === 0) ? row : row + 1)

            Grid {
                id: grid
                anchors.fill: parent
                objectName: "grid"

                columns: 4
                spacing: 0

                add: Transition {
                    NumberAnimation { properties: "x"; from: 0; duration: 500 }
                }
            }
        }
    }

    Text {
        id: element
        x: 25
        y: 30
        width: 50
        height: 0
        text: qsTr("My boxes")
        font.pixelSize: 12
    }

    ComboBox {
        x: 470
        y: 50
        width: 160
        height: 40
        id: comboBox
        model: ["Circle", "Box", "Triangle"]
        font.pixelSize: 20
        font.bold: true
        currentIndex: 0

        onCurrentIndexChanged: {
            switch(currentIndex) {
            case 0:
                shape.state = "CircleSelect"; break;
            case 1:
                shape.state = "BoxSelect"; break;
            case 2:
                shape.state = "TriangleSelect"; break;
            default:
                shape.state = "CircleSelect"; break;
            }
        }
    }

    ShapeSelect {
        x: 500
        y: 110

        id: shape
        objectName: "shape"
    }

    Button {
        x: 490
        y: 230
        width: 120
        height: 40
        text: "GENERATE"
        id: genBtn

        Timer {
            id: timer
            interval: 50
            running: false

            onTriggered: {
                Utils.generate();
            }
        }

        Timer {
            id: gen
            interval: 1000
            running: false
            repeat: false

            onTriggered: {
                timer.repeat = false;
                comboBox.enabled = true;
                genBtn.enabled = true;
            }
        }

        onClicked: {
            timer.repeat = true;
            timer.start();
            gen.start();
            comboBox.enabled = false;
            genBtn.enabled = false;
        }
    }

    Button {
        x: 490
        y: 290
        width: 120
        height: 40
        text: "Add By Cpp"

        onClicked: {
            switch(comboBox.currentIndex) {
            case 0:
                addComponent.createComponent("Circle.qml"); break;
            case 1:
                addComponent.createComponent("Box.qml"); break;
            case 2:
                addComponent.createComponent("Triangle.qml"); break;
            default:
                addComponent.createComponent("Circle.qml"); break;
            }

            Utils.bottomView();
        }
    }

    Button {
        x: 490
        y: 350
        width: 120
        height: 40
        text: "Add by Qml"

        onClicked: {
            switch(comboBox.currentIndex) {
            case 0:
                Utils.createComponent("Circle.qml"); break;
            case 1:
                Utils.createComponent("Box.qml"); break;
            case 2:
                Utils.createComponent("Triangle.qml"); break;
            default:
                Utils.createComponent("Circle.qml"); break;
            }

            Utils.bottomView();
        }
    }

    Button {
        x: 490
        y: 410
        width: 120
        height: 40
        text: "CLEAR"

        onClicked: {
            for(var i = grid.children.length; i > 0 ; i--) {
                grid.children[i-1].destroy();
            }
        }
    }
}
