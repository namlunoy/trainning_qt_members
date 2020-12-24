import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import "MyColor.js" as MyJS

ApplicationWindow {
    id: addWindow

    visible: true
    width: 300
    height: 300
    title: qsTr("Add member")
    modality: Qt.ApplicationModal

    InformationForm {
        height: parent.height
        width: parent.width
        memberName: ""
        memberAge: ""
        roleIndex: 0
        isAdd: true
        onAddMember: {
            addWindow.close()
        }
    }
}
