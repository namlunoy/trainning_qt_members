import QtQuick 2.0
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

ApplicationWindow {
    Rectangle {
        width: 300
        height: parent.height
        anchors.right: parent.right

        InformationForm {
            isAdd: true
        }
    }
}
