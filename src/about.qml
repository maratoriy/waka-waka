import QtQuick 2.15
import QtQuick.Controls 2.15
import Data 1.0

Page {
    title: Data.names[Data.settings.lang].aboutpage.title
    Column {
        anchors.centerIn: parent
        width: childrenRect.width
        height: childrenRect.height
        Image {
            width: 300
            height: 300
            source: "qrc:/images/icons/appicon.png";
        }
        Label {
            wrapMode: Label.WordWrap
            width: 300
            text: "Разработчик: <a href='https://vk.com/eto_kto_takoi'>Артем Киушкин</a>\nВерсия приложения: 1.0.4\nРепозиторий проекта: <a href='https://github.com/maratoriy/waka-waka'>GitHub</a>"
            onLinkActivated: Qt.openUrlExternally(link)
            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.NoButton
                cursorShape: parent.hoveredLink ? Qt.PointingHandCursor : Qt.ArrowCursor
            }
        }
    }
}
