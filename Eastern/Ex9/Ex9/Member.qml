import QtQuick 2.0
import MyEnum 1.0
import "MyColor.js" as MyJS

Item {
    property int currentMember: 0
    property string currentName: ""
    property string currentAge: ""
    property string currentRole: ""

    function addMember(memColor, memName, memAge) {
        listModel.append({"colorr": memColor, "name": memName, "age": memAge})
    }

    function setCurrentInfor(index, name, age, role) {
        currentMember = index
        currentName = name
        currentAge = age
        currentRole = role
    }

    function deleteMember(index) {
        listModel.remove(index)
        MyMemberList.deleteMember(index);
    }

    function updateMember(index, name, age, role) {
        listModel.clear()
        MyMemberList.updateMember(index, name, age, role);
    }

    signal chooseMember()

    Text {
        id: titleText

        height: parent.height /20
        width: parent.width
        font.pixelSize: titleText.height *2/3
        verticalAlignment: Text.AlignVCenter
        text: "Team Members"
        x: rect.x
    }

    Rectangle {
        id: rect

        height: parent.height *18/20
        width: parent.width *9/10
        border.color: "black"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: titleText.bottom
        color: "transparent"
    }

    ListModel {
        id: listModel
    }

    Component {
        id: listViewComponent

        Item {
            height: listView.height /8
            width: listView.width

            Rectangle {
                id: rectBG
                anchors.fill: parent
                color: "transparent"
            }

            Rectangle {
                height: parent.height
                width: parent.height
                color: colorr
            }

            Text {
                height: parent.height
                width: parent.width - 2* parent.height
                anchors.centerIn: parent
                text: name
                font.pixelSize: parent.height /3
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            Text {
                height: parent.height
                width: parent.height
                anchors.right: parent.right
                text: age
                font.pixelSize: parent.height /3
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    listView.currentIndex = index
                    setCurrentInfor(index, name, age, MyJS.getIndexFromColor(colorr))
                    chooseMember()
                }
            }

            onFocusChanged: {
                if(focus)
                    rectBG.color = "#bbb7b7"
                else
                    rectBG.color = "transparent"
            }
        }
    }

    ListView {
        id: listView

        height: parent.height *8/10
        width: parent.width *8/10
        anchors.centerIn: parent
        model: listModel
        delegate: listViewComponent
        clip: true
        currentIndex: -1
    }
}
