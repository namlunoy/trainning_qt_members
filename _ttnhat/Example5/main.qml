import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    visible: true
    width: 400
    height: 300
    title: qsTr("Hello World")
    Component {
        id : listComp1      
        ListComp1{
            anchors.fill: parent
            onItemSelected: {
                console.log("Current index" + indexClicked)
                if (indexClicked == 1)
                {
                    loader.sourceComponent = listComp2
                }
            }
        }
    }

    Component {
        id : listComp2
        ListComp2{
            anchors.fill: parent
            onItemSelected: {
                console.log("Current index" + indexClicked)
                if (indexClicked == 2)
                {
                    loader.sourceComponent = listComp1
                }
            }
        }
    }
    Loader {
        id : loader
       anchors.fill: parent
       sourceComponent: listComp1
    }
}
