import QtQuick 2.0

Rectangle {
    width: 100
    height: 100
    state: "CircleSelect"

    property string shapeColor: "white"
    property string text: "0"

    Loader {
        id: myLoader
    }

    Component { id: box; Box { color: shapeColor; insideText: text; } }
    Component { id: circle; Circle { color: shapeColor; insideText: text; } }
    Component { id: triangle; Triangle{ color: shapeColor; insideText: text; } }

    states: [
        State {
            name: "CircleSelect"
            PropertyChanges { target: myLoader; sourceComponent: circle }
        },
        State {
            name: "BoxSelect"
            PropertyChanges { target: myLoader; sourceComponent: box }
        },
        State {
            name: "TriangleSelect"
            PropertyChanges { target: myLoader; sourceComponent: triangle }
        }
    ]
}
