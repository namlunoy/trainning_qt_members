import QtQuick 2.0

Rectangle {
    border.color: "black"
    border.width: 5
    radius: width / 2
    Component.onCompleted: console.log(width)
}
