import QtQuick 2.12
import QtQuick.Window 2.12
import MyEnum 1.0

Window {
    property var charName: ["Eren", "Luffy", "Naruto", "Saitama", "Songoku"]

    function getSourceImg() {
        switch (MyCharacter.character)
        {
            case CharacterEnum.E_EREN:
                return "qrc:/img_eren";
            case CharacterEnum.E_LUFFY:
                return "qrc:/img_luffy";
            case CharacterEnum.E_NARUTO:
                return "qrc:/img_naruto";
            case CharacterEnum.E_SAITAMA:
                return "qrc:/img_saitama";
            case CharacterEnum.E_SONGOKU:
                return "qrc:/img_songoku";
            default:
                return "";
        }
    }

    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    ListView {
        id: listView

        height: parent.height / 6
        width: parent.width
        orientation: ListView.Horizontal
        model: ListModel {
            ListElement {
                name: "eren"
            }
            ListElement {
                name: "luffy"
            }
            ListElement {
                name: "naruto"
            }
            ListElement {
                name: "saitama"
            }
            ListElement {
                name: "songoku"
            }
        }

        delegate: Component {
            Rectangle {
                height: listView.height
                width: listView.width / 5
                color: "black"
                border.color: "white"

                onFocusChanged: {
                    if (focus)
                        color = "green"
                    else
                        color = "black"
                }

                Text {
                    anchors.fill: parent
                    text: charName[index]
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 25
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        listView.currentIndex = index  
                        MyCharacter.character = listView.currentIndex
                    }
                }
            }
        }
        currentIndex: MyCharacter.character
    }

    Rectangle {
        height: parent.height * 5/6
        width: parent.width
        anchors.top: listView.bottom
        color: "black"
        border.color: "white"

        Image {
            id: image

            width: parent.width * 4/5
            height: parent.height * 4/5
            anchors.centerIn: parent
            source: getSourceImg()
            Connections {
                target: MyCharacter
                onCharacterChanged: {
                    image.source = getSourceImg()
                }
            }
        }
    }
}
