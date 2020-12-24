import QtQuick 2.0
import "MyColor.js" as MyJS

Item {
    property int currentMember: -1
    property string currentName: ""
    property string currentAge: ""
    property string currentRole: ""

    function addMember(name, age, role) {
        memberListModel.addMember(name, age, role)
    }

    function setCurrentInfor(index, name, age, role) {
        currentMember = index
        currentName = name
        currentAge = age
        currentRole = role
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
                color: MyJS.getColorFromRole(memberElement.role)
            }

            Text {
                height: parent.height
                width: parent.width - 2* parent.height
                anchors.centerIn: parent
                text: memberElement.name
                font.pixelSize: parent.height /3
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            Text {
                height: parent.height
                width: parent.height
                anchors.right: parent.right
                text: memberElement.age
                font.pixelSize: parent.height /3
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    listView.currentIndex = index
                    setCurrentInfor(index, memberElement.name, memberElement.age, memberElement.role)
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
        model: MemberListModel
        delegate: listViewComponent
        clip: true
        currentIndex: currentMember
    }
}
