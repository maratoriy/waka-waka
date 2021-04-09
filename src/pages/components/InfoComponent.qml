import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import Data 1.0

ListView {
    id: root
    boundsBehavior: ListView.StopAtBounds
    property bool menu: false
    clip: true
    ScrollBar.vertical: ScrollBar { id: scrollBar}
    delegate: Control {
        width: root.width-scrollBar.width
        height: 50+label.paintedHeight*label.visible+ (image.paintedHeight+40+itemDelegate.height/4)*image.visible
        ItemDelegate {
            id: itemDelegate
            width: parent.width
            text: modelData[Data.settings.lang].name
            font.pointSize: 16
            onClicked: {
                column.visible=!column.visible
            }
            Column {
                id: column
                anchors.topMargin: itemDelegate.height/4
                anchors.top: itemDelegate.bottom
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
                width: parent.width*0.98
                height: 1
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                color: Data.styles.actions[root.Material.theme]
            }
        }
    }
}
