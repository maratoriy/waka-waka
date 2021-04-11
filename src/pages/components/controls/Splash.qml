import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtQuick.Controls.Material 2.12

Window {
    id: splash
    property bool darkT
    signal timeout
    flags: Qt.SplashScreen
    Control {
        anchors.fill: parent
        background: Rectangle {
            color: darkT ? "#303030" : "white"
        }
        Image {
            id: img
            visible: false
            source: "qrc:/images/icons/appicon.png"
            width: 200
            height: 200
            anchors.centerIn: parent
            sourceSize.width: width
            sourceSize.height: height
        }
        Label {
            id: lbl
            text: "WakaWaka"
            anchors.centerIn: parent
            color: !darkT ? "#303030" : "white"
            font.pixelSize: img.height*0.5
        }
        Timer {
            interval: 2000; running: true; repeat: false
                onTriggered: {
                    lbl.visible=false
                    img.visible=true
            }
        }

    }
    BusyIndicator {
        running: true
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        Material.accent: darkT? Material.DeepPurple : Material.Pink
        anchors.bottomMargin: parent.height/6
    }

    Timer {
        interval: 4000; running: true; repeat: false
            onTriggered: {
                visible = false
                splash.timeout()
        }
    }
}
