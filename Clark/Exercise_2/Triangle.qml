import QtQuick 2.0

Rectangle {
    width: 100
    height: 100

    property string insideText: "white"
    property string color: "white"
    z: 1

    Text {
        z: 3
        text: qsTr(parent.insideText)
        font.bold: true
        font.pointSize: 20
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: "black"
        anchors.fill: parent
    }

    Canvas {
        z: 2
        id: drawTriangle
        anchors.fill:parent

        onPaint: {
            var context = getContext("2d");
            var width = 5;

            // the triangle
            context.beginPath();
            context.moveTo(width / 2, 100 - width / 2);
            context.lineTo(100 - width / 2, 100 - width / 2);
            context.lineTo(50, width / 2);
            context.closePath();

            // the outline
            context.lineWidth = width;
            context.strokeStyle = "black"
            context.stroke();

            // the fill color
            context.fillStyle = color;
            context.fill();
        }
    }

    onColorChanged: {
        drawTriangle.requestPaint();
    }
}
