import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Controls 1.4
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.15
import "pages/components"
import Data 1.0

Page {
    id: root
    title: Data.names[Data.settings.lang].homepage.title
    Control {
        id: childRoot
        width: parent.width*0.90
        height: parent.height*0.90
        anchors.centerIn: parent
        Control {
            width: parent.width
            height: parent.height
            anchors.top: parent.top
            background: Rectangle {
                color: "white"
                radius: 10
            }

            Control {
                width: parent.width*0.95
                height: parent.height*0.98
                anchors.centerIn: parent
                Label {
                    id: nameText
                    //anchors.horizontalCenter: parent.horizontalCenter
                    font.pointSize: root.font.pointSize*1.4
                    width: parent.width
                    text: Data.programName
                }
                Label {
                    id: infoText
                    width: parent.width
                    font.pointSize: root.font.pointSize*1.2
                    wrapMode: Label.Wrap
                    anchors.top:  nameText.bottom
                    text: Data.names[Data.settings.lang].homepage.welcome
                }
                InfoComponent {
                    width: parent.width
                    height: parent.height*0.6
                    anchors.top: infoText.bottom
                    anchors.topMargin: 50
                    //Layout.fillHeight: true
                    Material.theme: Material.Light
                    model: Data.helpModel
                }
            }
        }
    }
}
