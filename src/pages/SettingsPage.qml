import QtQuick 2.14
import QtQuick.Controls 2.14
import Data 1.0

Page {
    title: qsTr("Settings")
    property int visibility: visibilityDelegate.checked ? 5 : 4
    property int theme: themeDelegate.position===1 ? Data.themes.darkTheme : Data.themes.lightTheme
    property string lang: langcb.currentText
    property int fontsize: fontsizecb.currentText
    Column {
        anchors.fill: parent
        SwitchDelegate {
            id: themeDelegate
            width: parent.width
            text: Data.names[Data.settings.lang].settings['darkmode']
            Component.onCompleted: checked= Data.settings.theme===Data.themes.darkTheme ? 1 : 0
        }
        SwitchDelegate {
            id: visibilityDelegate
            width: parent.width
            text: Data.names[Data.settings.lang].settings['fullscreen']
            Component.onCompleted: checked= Data.settings.visibility===5
        }
        ItemDelegate {
            width: parent.width
            text: Data.names[Data.settings.lang].settings['lang']
            onClicked: langcb.popup.visible ? langcb.popup.close() : langcb.popup.open()
            ComboBox {
                id: langcb
                anchors.right: parent.right
                model: Data.langList
                Component.onCompleted: currentIndex=Data.langList.indexOf(Data.settings.lang)
            }
        }
        ItemDelegate {
            width: parent.width
            text: Data.names[Data.settings.lang].settings['fontsize']
            onClicked: fontsizecb.popup.visible ? fontsizecb.popup.close() : fontsizecb.popup.open()
            ComboBox {
                id: fontsizecb
                anchors.right: parent.right
                model: Data.fontsizelist
                Component.onCompleted: currentIndex=Data.fontsizelist.indexOf(Data.settings.fontsize)
            }
        }
    }

}
