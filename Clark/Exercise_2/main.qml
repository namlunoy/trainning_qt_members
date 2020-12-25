import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.1

Window {
    visible: true
    width: 655
    height: 480
    title: qsTr("Have fun with boxes")

    function createComponent(shapePath) {
        var component;
        var sprite;

        component = Qt.createComponent(shapePath);

        if (component.status === Component.Ready) {
            sprite = component.createObject(grid, {color: shape.shapeColor, insideText: shape.text});

            if (sprite === null) {
                console.log("Error: creating object failed!");
            }
        }
        else if (component.status === Component.Error) {
            console.log("Error: loading component failed!");
        }
    }

    function bottomView() {
        if (flick.contentHeight > 400) {
            flick.contentY = flick.contentHeight - 400;
        }
    }

    function getRandomInt(min, max) {
        min = Math.ceil(min);
        max = Math.floor(max);
        return Math.floor(Math.random() * (max - min + 1)) + min;
    }

    function getColor() {
        return '#'+(0x1000000+(Math.random())*0xffffff).toString(16).substr(1,6);
    }

    function isColorBlack(color) {
        color = color.substring(1);      // strip #
        var rgb = parseInt(color, 16);   // convert rrggbb to decimal
        var r = (rgb >> 16) & 0xff;  // extract red
        var g = (rgb >>  8) & 0xff;  // extract green
        var b = (rgb >>  0) & 0xff;  // extract blue

        var luma = 0.2126 * r + 0.7152 * g + 0.0722 * b; // per ITU-R BT.709

        if (luma < 40) {
            return true;
        }
        else {
            return false;
        }
    }

    function getRandomColor() {
        var color = getColor();

        while (isColorBlack(color)) {
            color = getColor();
        }

        return color;
    }

    function generate() {
        shape.text = getRandomInt(0, 100).toString();
        shape.shapeColor = getRandomColor();
        comboBox.currentIndex = getRandomInt(0, 2);
    }

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
                    NumberAnimation { properties: "x, y"; from: 0; duration: 500 }
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
    }

    ShapeSelect {
        x: 500
        y: 110

        id: shape
        objectName: "shape"
        state: (comboBox.currentIndex === 0) ? "CircleSelect" : ((comboBox.currentIndex === 1) ? "BoxSelect" : "TriangleSelect")
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
                generate();
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
                addComponent.createComponent("Circle.qml", shape.shapeColor, shape.text); break;
            case 1:
                addComponent.createComponent("Box.qml", shape.shapeColor, shape.text); break;
            case 2:
                addComponent.createComponent("Triangle.qml", shape.shapeColor, shape.text); break;
            default:
                addComponent.createComponent("Circle.qml", shape.shapeColor, shape.text); break;
            }

            bottomView();
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
                createComponent("Circle.qml"); break;
            case 1:
                createComponent("Box.qml"); break;
            case 2:
                createComponent("Triangle.qml"); break;
            default:
                createComponent("Circle.qml"); break;
            }

            bottomView();
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
