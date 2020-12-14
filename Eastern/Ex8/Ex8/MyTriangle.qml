import QtQuick 2.0
import QtQuick.Shapes 1.12

Shape {
    id: shape

    ShapePath {
        strokeWidth: 5
        strokeColor: "black"
        strokeStyle: ShapePath.SolidLine
        fillColor: itemShape.shapeColor
        startX: shape.x + (shape.width / 2)
        startY: shape.y
        PathLine { x: shape.x; y: shape.y + shape.height}
        PathLine { x: shape.x + shape.width; y: shape.y + shape.height }
        PathLine { x: shape.x + (shape.width / 2); y: shape.y }
    }
}
