import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import Data 1.0

ListView {
    id: root
    boundsBehavior: ListView.StopAtBounds
    property bool menu: false
    clip: true
    ScrollIndicator.vertical: ScrollIndicator { id: scrollBar}
    height: contentItem.childrenRect.height
    delegate: Column {
        width: root.width-scrollBar.width
        height: column.visible ? childrenRect.height : itemDelegate.height
        ItemDelegate {
            id: itemDelegate
            width: parent.width
            text: modelData[Data.settings.lang].name
            font.pointSize: 16
            onClicked: {
                column.visible=!column.visible
            }
        }
        Column {
            id: column
            height: childrenRect.height
            width: parent.width
            visible: false
            Label {
                id: label
                width: itemDelegate.parent.width
                leftPadding: 20
                font.pointSize: Qt.application.font.pointSize*1.5
                wrapMode: Label.Wrap
                text: qsTr(modelData[Data.settings.lang].text)
            }
            Image {
                id: image
                anchors.topMargin: 40
                width: menu ? parent.width : parent.width*modelData.image.width
                height: sourceSize.height/sourceSize.width*width
                source: modelData.image.source
            }
        }
        Rectangle {
            width: parent.width
            height: 1
            color: menu ? 'grey' : Data.styles.actions[root.Material.theme]
        }
    }
}
