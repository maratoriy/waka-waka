import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12
import Backend 1.0
import Data 1.0

Control {
    id: dialog
    background: Rectangle {
        //radius: 5
        color: root.Material.theme===Material.Light ? 'white' : '#303030'
    }

    property string curSymb;
    Column {
        anchors.fill: parent
        Rectangle {
            height: 30
            //radius: 5
            width: parent.width
            color: Data.styles.actions[root.Material.theme]
            MouseArea {
                id: dragArea
                anchors.fill: parent
                property int previousX
                property int previousY
                onPressed: {
                    previousX = mouseX
                    previousY = mouseY
                }
                onMouseXChanged: {
                    var dx = mouseX - previousX
                    dialog.x=(dialog.x + dx)
                }
                onMouseYChanged: {
                    var dy = mouseY - previousY
                    dialog.y=(dialog.y + dy)
                }
            }
            ToolButton {
                width: height
                height: parent.height
                anchors.right: parent.right
                icon.color: "white"
                icon.source: Data.urls.icons["close"]
                onClicked: dialog.visible=false
            }
        }
        Control {
            width: parent.width
            height: parent.height-30
            GridView {
                anchors.fill: parent
                id: gridView
                clip: true
                model: Data.symbols
                cellHeight: 30
                cellWidth: 30
                delegate: Control {
                    width: gridView.cellWidth
                    height: gridView.cellHeight
                    Layout.alignment: Qt.AlignCenter
                    ToolButton {
                        contentItem: Text {
                            text: modelData
                            color: root.Material.theme===Material.Dark ? (parent.down ? "#AFAFAF" : "#FFFFFF") : (parent.down ? "grey" : "#000000")
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.pointSize: root.font.pointSize*1.2
                        }

                        anchors.centerIn: parent
                        onClicked: curSymb=modelData
                    }
                }
            }
        }
    }
}
