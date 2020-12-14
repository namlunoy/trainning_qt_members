import QtQuick 2.0

Rectangle {
    width: 100
    height: 100
    state: "CircleSelect"

    property string shapeColor: "white"
    property string text: "0"

    Box { id: box; }
    Circle { id: circle; }
    Triangle { id: triangle; }


    states: [
        State {
            name: "CircleSelect"
            PropertyChanges { target: box; visible: false; color: shapeColor; insideText: text }
            PropertyChanges { target: circle; visible: true; color: shapeColor; insideText: text }
            PropertyChanges { target: triangle; visible: false; color: shapeColor; insideText: text }
        },
        State {
            name: "BoxSelect"
            PropertyChanges { target: box; visible: true; color: shapeColor; insideText: text }
            PropertyChanges { target: circle; visible: false; color: shapeColor; insideText: text }
            PropertyChanges { target: triangle; visible: false; color: shapeColor; insideText: text }
        },
        State {
            name: "TriangleSelect"
            PropertyChanges { target: box; visible: false; color: shapeColor; insideText: text }
            PropertyChanges { target: circle; visible: false; color: shapeColor; insideText: text }
            PropertyChanges { target: triangle; visible: true; color: shapeColor; insideText: text; }
        }
    ]
}
