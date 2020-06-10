import QtQuick 2.13
import QtQuick.Window 2.13

Window {
    visible: true
    width: 300
    height: 300
    title: qsTr("qml loader")

    Loader {
        id: myLoader
        anchors.fill: parent
        sourceComponent: menu1
    }


    Component {
        id: menu1
        Menu1 {
            onItemSelected: {
                if(index == 1)
                {
                    myLoader.sourceComponent = menu2
                }
            }
        }
    }

    Component {
        id: menu2
        Menu2 {
            onItemSelected: {
                if(index == 2)
                {
                    myLoader.sourceComponent = menu1
                }
            }
        }
    }
}
