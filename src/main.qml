import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Controls.Material 2.14
import Qt.labs.settings 1.1
import QtQuick.Window 2.14
import QtWinExtras 1.0

import "pages"
import "pages/components"
import "pages/components/controls"
import Data 1.0
import Backend 1.0

ApplicationWindow {
    id: root
    title: Data.programName
    minimumWidth: Screen.width/2
    minimumHeight: Screen.height/2
    font.family: robotoMedium.name
    Material.theme: settingsLoader.item.theme
    visible: true
    Splash {
        id: splash
        visible: false
        x: root.x
        y: root.y
        width: root.width
        height: root.height
    }
    Component.onCompleted: {
        setLightMode(Data.settings.theme)
        splash.darkT=Data.settings.theme===Material.Dark
        font.pointSize = Data.settings.fontsize
        visibility     = (Data.settings.visibility!==3&&Data.settings.visibility!==0) ? Data.settings.visibility : 4
    }
    flags: Qt.Window | Qt.CustomizeWindowHint
    header: ToolBar {
        height: Screen.height*0.09
        MouseArea {
            id: dragArea
            enabled: Data.deckstopMode && root.visibility<4
            anchors.fill: parent
            property int previousX
            property int previousY
            onPressed: {
                previousX = mouseX
                previousY = mouseY
            }
            onMouseXChanged: {
                var dx = mouseX - previousX
                root.setX(root.x + dx)
            }
            onMouseYChanged: {
                var dy = mouseY - previousY
                root.setY(root.y + dy)
            }
        }
        ToolButton {
            id: leftDrawerButton
            height: parent.height
            width: height
            anchors.left: parent.left
            icon.source: Data.urls.icons["menu"]
            icon.color: "white"
            onClicked: leftDrawer.open()
        }
        Label {
            anchors.centerIn: parent
            text: loader.item.title
            font.pixelSize: parent.height*0.35
            color: "white"
        }

        Control {
            id: windowButtons
            height: Screen.height*0.035
            width: Screen.width*0.09
            anchors.top: parent.top
            anchors.right: parent.right
            visible: Data.deckstopMode
            Row {
                anchors.fill: parent
                ToolButton {
                    width: parent.width/3
                    height: parent.height
//                    visible: root.visibility!==5
                    icon.color: "white"
                    icon.source: Data.urls.icons["hide"]
                    onClicked: {
                        root.visibility=3
                     }
                }
                ToolButton {
                    width: parent.width/3
                    height: parent.height
                    icon.color: "white"
                    icon.source: Data.urls.icons[(root.visibility==2) ? "maxWin" : "minWin"]
                    onClicked: {
                        switch(root.visibility) {
                           case 5: root.visibility=4; break;
                           case 4: root.visibility=2; break;
                           case 2: root.visibility=4; break;
                        }
                    }
                }
                ToolButton {
                    width: parent.width/3
                    height: parent.height
                    icon.color: "white"
                    icon.source: Data.urls.icons["close"]
                    onClicked: root.close()
                }
            }
        }
        ToolButton {
            id: helpButton
            height: moreButton.height
            width: moreButton.width
            anchors.right: moreButton.left
            anchors.top: moreButton.top
            icon.source: Data.urls.icons['help']
            icon.color: 'white'
            onClicked: rightDrawer.open()
        }

        ToolButton {
            id: moreButton
            height: Data.deckstopMode ? Math.min(Screen.height*0.035, parent.height/2.5) : parent.height
            width: Data.deckstopMode ? Screen.width*0.03 : height
            anchors.top: Data.deckstopMode ? windowButtons.bottom : parent.top
            anchors.right: parent.right
            icon.source: Data.urls.icons[Data.deckstopMode ? "more" : "moreV"]
            icon.color: "white"
            onClicked: settingsDrawer.open()
        }
    }
    Drawer {
        edge: Qt.RightEdge
        id: rightDrawer
        width: root.width*0.5
        height: root.height
        InfoComponent {
            anchors.fill: parent
            model: Data.helpModel
            menu: true
        }
    }

    Drawer {
        id: leftDrawer
        edge: Qt.LeftEdge
        height: parent.height
        width: leftDrawerHeader.height*5
        Control {
            anchors.fill: parent
            Control {
                id: leftDrawerHeader
                height: Math.max(parent.height*0.08, 70)
                width: parent.width
                anchors.top: parent.top

                Item {
                    height: parent.height
                    width: height
                    anchors.left: parent.left
                    Image {
                        width: parent.width*0.8
                        height: width
                        anchors.centerIn: parent
                        source: "qrc:/images/icons/appicon.png"
                        sourceSize.width: width
                        sourceSize.height: height
                    }
                }
                Label {
                    anchors.centerIn: parent
                    text: Data.programName
                    horizontalAlignment: Label.AlignLeft
                    verticalAlignment:  Label.AlignVCenter
                    font.pixelSize: parent.height*0.45
                }
                Item {
                    height: parent.height
                    width: height
                    anchors.right: parent.right
                    ToolButton {
                        height: parent.height*0.8
                        width: height
                        anchors.centerIn: parent
                        icon.source: Data.urls.icons["close"]
                        onClicked: leftDrawer.close()
                    }
                }
            }
            ListView {
                width: parent.width
                height: parent.height-leftDrawerHeader.height
                anchors.top: leftDrawerHeader.bottom
                model: ListModel {
                    ListElement { name: qsTr("Home");     url: "home"}
                    ListElement { name: qsTr("Open");     url: "open"}
                    ListElement { name: qsTr("Create");   url: "create"}
                    //ListElement { name: qsTr("Settings"); url: "settings"}
                    ListElement { name: qsTr("About");    url: "about"}
                }
                delegate: ItemDelegate {
                    width: parent.width
                    text: Data.names[Data.settings.lang]['navmenu'][url]
                    //enabled: url !== loader.page
                    icon.source: Data.urls.icons[url]
                    onClicked: {
                        loader.sourceComponent=loadingComponent
                        loader.source= url+".qml"
                        leftDrawer.close()
                    }
                }
            }

        }
    }
    Component {
        id: loadingComponent
        Control {
            property string title: "Loading"
            Text {
                anchors.centerIn: parent
                text: qsTr("Loading...")
            }
        }
    }

    Loader {
        id: loader
        anchors.fill: parent
        source: "home.qml"
    }
    Drawer {
        id: settingsDrawer
        height: settingsLoader.item.height
        width: parent.width
        edge: Qt.BottomEdge
        Loader {
            id: settingsLoader
            width: parent.width
            height: childrenRect.height
            sourceComponent: settingsComponent
        }
    }
    function setLightMode(mode) {
        switch(mode) {
        case Material.Dark: Material.theme=Material.Dark; Material.primary=Material.DeepPurple; Material.accent=Material.DeepPurple;break;
        case Material.Light: Material.theme=Material.Light; Material.primary=Material.Purple; Material.accent=Material.Purple; break;
        }
    }
    Component {
        id: settingsComponent
        SettingsPage {
            onThemeChanged: { root.setLightMode(theme); Data.settings.theme=theme }
            onVisibilityChanged: { root.visibility=visibility; Data.settings.visibility=visibility }
            property bool langcb: false
            onLangChanged: langcb? Data.settings.lang=lang : langcb=true
            property bool fontsizecb: false
            onFontsizeChanged: {
                if(fontsizecb) {
                       root.font.pointSize=fontsize
                       Data.settings.fontsize=fontsize
                } else fontsizecb=true
            }
        }
    }
    FontLoader { id: robotoLight; source: Data.urls.fonts.Roboto.light }
    FontLoader { id: robotoMedium; source: Data.urls.fonts.Roboto.medium }
}
