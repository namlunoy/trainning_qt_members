import QtQuick 2.0

Item {
    id: item

    signal switchPage()

    property variant menuName: []
    property int switchIdx: -1
    property string colorChange: ""

    ListView {
        id: listView

        anchors.fill: parent
        model: ListModel {
            ListElement {
                name: "Menu 1"
            }
            ListElement {
                name: "Menu 2"
            }
            ListElement {
                name: "Menu 3"
            }
        }

        delegate: Component {
            Rectangle {
                property string colorBG: "black"

                width: item.width
                height: item.height / 3
                color: colorBG

                Text {
                    anchors.fill: parent
                    text: menuName[index].toString()
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 50
                    color: "white"
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        listView.currentIndex = index
                        if (index == switchIdx)
                            switchPage()
                    }
                }

                onFocusChanged: {
                    if (focus)
                        colorBG = colorChange
                    else
                        colorBG = "black"
                    console.log(index+" "+colorBG+" "+focus)
                }
            }
        }

        currentIndex: -1
    }
}
