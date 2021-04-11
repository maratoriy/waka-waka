import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.12
import Data 1.0
import QtQml.Models 2.15
import QtQuick.Layouts 1.15

Control {
    property var contentObj
    height: childrenRect.height
    function init() {
        swipeView.addItem(comp.createObject(swipeView, {}))
        swipeView.addItem(comp.createObject(swipeView, {}))
        for(let i=0;i<contentObj['number'];i++) {
            let nod=contentObj['nods']['nod'+i]
            let pnod=contentObj['pnods']['nod'+i]
            swipeView.itemAt(0).listModel.append({ind: i, nod: nod['name'], subNods: pnod['subNods']})
            swipeView.itemAt(1).listModel.append({ind: i, nod: nod['name'], subNods: nod['subNods']})
        }
    }
    function getObj() {

    }
    Control {
        height: 500
        width: parent.width
        TabBar {
            id: tabBar
            width: parent.width
            anchors.top: parent.top
            TabButton {
                text: Data.names[Data.settings.lang].tasks['TableAnswer'].result.pupil
            }
            TabButton {
                text: Data.names[Data.settings.lang].tasks['TableAnswer'].result.answer
            }
        }
        SwipeView {
            id: swipeView
            anchors.bottom: parent.bottom
            currentIndex: tabBar.currentIndex
            height: 400
            width: parent.width
            interactive: false
            clip: true
        }
        Component {
            id: comp
            ListView {
                property alias listModel: _listModel
                ListModel {
                    id: _listModel

                }
                id: listView
                width: swipeView.width
                model: listModel
                clip: true
                height: 400
                ScrollBar.vertical: ScrollBar { id: scrollBar; width: 5 }
                spacing: 10
                delegate: Row {
                    width: listView.width
                    height: 60
                    topPadding: height/10
                    property alias subList: subListView
                    property alias subListMod: subListModel
                    TextField {
                        id: mainTextEdit
                        padding: 20
                        selectByMouse: true
                        background: Rectangle {
                            radius: 2
                            border.color: Data.styles.actions[root.Material.theme]
                            border.width: 1
                        }
                        text: nod
                        readOnly: true
                    }
                    ToolSeparator {
                        id: separator
                    }
                    ListModel {
                        id: subListModel
                    }
                    Component.onCompleted: {
                        for(let i=0;i<subNods['number'];i++) {
                            subListModel.append({ ind: i, subNod: subNods['subNod'+i]})
                        }
                    }

                    ListView {
                        id: subListView
                        width: parent.width-mainTextEdit.width/*-addTextEditButton.width*/-separator.width-scrollBar.width
                        height: parent.height
                        clip: true
                        orientation: Qt.Horizontal
                        model: subListModel
                        spacing: width/50
                        ScrollBar.horizontal: ScrollBar { id: subScrollBar }
                        delegate: TextField {
                            text: subNod
                            readOnly: true
                            padding: 20
                            bottomInset: subScrollBar.height*0.25
                            //rightPadding: subCloseTextEditButton.width+20
                            selectByMouse: true
                            background: Rectangle {
                                radius: 15
                                border.color: Data.styles.actions[root.Material.theme]
                                border.width: 1
                            }
                        }
                    }
                }
            }
        }
    }
}
