import QtQuick 2.14
import QtQuick.Controls 2.14
import Data 1.0

Page {
    title: qsTr("Settings")
    property int visibility: visibilityDelegate.checked ? 5 : 4
    property int theme: themeDelegate.position===1 ? Data.themes.darkTheme : Data.themes.lightTheme
    property string lang: langcb.currentText
    property int fontsize: fontsizecb.value
    height: flick.height
    Flickable {
        id: flick
        anchors.fill: parent
        height: contentItem.childrenRect.height
        ScrollIndicator.vertical: ScrollIndicator { }
    Column {
        height: childrenRect.height*4
        width: parent.width
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

            SpinBox {
                id: fontsizecb
                anchors.right: parent.right
                from: 10; to: 16
                Component.onCompleted: value=Data.settings.fontsize
            }
        }
    }
    }
}
