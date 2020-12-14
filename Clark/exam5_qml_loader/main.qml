import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    visible: true
    width: 320
    height: 480
    title: qsTr("Hello Loader")

    Component {
        id: menu1
        Menu1 {
            onSelectMenu: {
                if (idx == 1) {
                    myLoader.sourceComponent = menu2
                }
            }
        }
    }

    Component {
        id: menu2
        Menu2 {
            onSelectMenu: {
                if (idx == 2) {
                    myLoader.sourceComponent = menu1
                }
            }
        }
    }

    Loader {
        id: myLoader
        anchors.fill: parent
    }

    Component.onCompleted: {
        myLoader.sourceComponent = menu1
    }

}
