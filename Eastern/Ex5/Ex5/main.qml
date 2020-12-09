import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    id: window
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    Component {
        id: menu1

        MyList {
            menuName: ["Menu A", "Menu B >>", "Menu C"]
            switchIdx: 1
            colorChange: "green"
            onSwitchPage: {
                loader.sourceComponent = menu2
            }
        }
    }

    Component {
        id: menu2

        MyList {
            menuName: ["Menu C", "Menu D", "<< Back"]
            switchIdx: 2
            colorChange: "blue"
            onSwitchPage: {
                loader.sourceComponent = menu1
            }
        }
    }

    Loader {
        id: loader

        width: window.width
        height: window.height
        sourceComponent: menu1
    }
}
