import QtQuick 2.0
import QtQuick.Shapes 1.12

Item
{
    id: itemShape

    property int shapeType: Math.random() * 3
    property int shapeNumber: Math.random() * 100
    property string shapeColor: Qt.rgba(Math.random(),Math.random(),Math.random(),1)

    function genShape() {
        itemShape.shapeType = Math.random() * 3
        itemShape.shapeNumber = Math.random() * 100
        itemShape.shapeColor = Qt.rgba(Math.random(),Math.random(),Math.random(),1)
    }

    function anchorNumberText() {
        if (itemShape.shapeType != 2)
            shapeNumText.verticalAlignment = Text.AlignVCenter
        else
            shapeNumText.verticalAlignment = Text.AlignBottom
    }

    function loadShape() {
        switch(itemShape.shapeType) {
        case 0:
            loader.sourceComponent = boxComponent
            break
        case 1:
            loader.sourceComponent = circleComponent
            break
        case 2:
            loader.sourceComponent = triangleComponent
            break
        default:
            loader.sourceComponent = ""
            break
        }
    }

    Component {
        id: boxComponent

        MyBox {
            anchors.fill: parent
            color: itemShape.shapeColor
            Component.onCompleted: {
                itemShape.anchorNumberText()
            }
        }
    }

    Component {
        id: circleComponent

        MyCirCle {
            anchors.fill: parent
            color: itemShape.shapeColor
            Component.onCompleted: {
                itemShape.anchorNumberText()
            }
        }
    }

    Component {
        id: triangleComponent

        MyTriangle {
             anchors.fill: parent
        }
    }

    Loader {
        id: loader

        anchors.fill: itemShape
        Component.onCompleted: loadShape()
    }

    Text {
        id: shapeNumText

        width: parent.width
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter
        text: itemShape.shapeNumber.toString()
        font.pixelSize: shapeNumText.height * 3/7
        horizontalAlignment: Text.AlignHCenter
        font.bold: true
    }

    onShapeTypeChanged: {
        anchorNumberText()
        loadShape()
    }
}
