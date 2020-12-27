import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.12
import Data 1.0
import QtQml.Models 2.15

Control {
    property var contentObj
    function init(contentObj) {
        for(let i=0;i<contentObj['number'];i++) {
            let nod=contentObj['nods']['nod'+i]
            listModel.append({ind: i, nodd: nod['name'], subNods: nod['subNods']})
        }
    }
    function reset() {
        listModel.clear()
        listModel.append({ind: 0})
    }
    function obj() {
        var obj={}
        obj['number']=listView.count
        let subObj={}
        for(let i=0;i<listView.count;i++) {
            let nod={}
            nod['name']=listView.itemAtIndex(i).nod
            let subNods={}
            subNods['number']=listView.itemAtIndex(i).subList.count
            for(let j=0;j<listView.itemAtIndex(i).subList.count;j++) {
                subNods['subNod'+j]=listView.itemAtIndex(i).subList.itemAtIndex(j).text
            }
            nod['subNods']=subNods
            subObj['nod'+i]=nod
        }
        obj['nods']=subObj
        return obj
    }
    ListModel {
        id: listModel
        function reind() {
            for(let i=0;i<count;i++) setProperty(i, 'ind', i)
        }
    }

    ListView {
        id: listView
        anchors.fill: parent
        model: listModel
        clip: true
        ScrollBar.vertical: ScrollBar { id: scrollBar }
        header: ToolButton {
            text: qsTr("Add row")
            Material.theme: Material.Dark
            rightInset: scrollBar.width
            background: Rectangle {
                radius: 5
                color: Data.styles.actions[root.Material.theme]
            }
            width: parent.width
            onClicked: listModel.append({ind: listModel.count})
        }
        spacing: 10
        delegate: Row {
            width: listView.width
            height: listView.height/4
            topPadding: height/10
            property string nod: mainTextEdit.text
            property alias subList: subListView
            property alias subModel: subListModel
            Component.onCompleted: {
                for(let i=0;i<subNods['number'];i++) {
                    subListModel.append({ subInd: i, subNod: subNods['subNod'+i]})
                }
            }
            TextField {
                id: mainTextEdit
                padding: 20
                selectByMouse: true
                background: Rectangle {
                    radius: 2
                    border.color: Data.styles.actions[root.Material.theme]
                    border.width: 1
                }
                text: nodd
                placeholderText: Data.names[Data.settings.lang].tasks['TableAnswer'].create.nod
            }
            ToolSeparator {
                id: separator
            }
            ListModel {
                id: subListModel
                function reind() {
                    for(let i=0;i<count;i++) setProperty(i, 'subInd', i)
                }
            }
            ListView {
                id: subListView
                width: parent.width-mainTextEdit.width-addTextEditButton.width*2-separator.width-scrollBar.width
                height: parent.height
                clip: true
                orientation: Qt.Horizontal
                model: subListModel
                spacing: width/50
                ScrollBar.horizontal: ScrollBar { id: subScrollBar }
                delegate: TextField {
                    padding: 20
                    bottomInset: subScrollBar.height*0.25
                    rightPadding: subCloseTextEditButton.width+20
                    selectByMouse: true
                    background: Rectangle {
                        radius: 15
                        border.color: Data.styles.actions[root.Material.theme]
                        border.width: 1
                    }
                    text: subNod
                    ToolButton {
                        id: subCloseTextEditButton
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        height: parent.height*0.75
                        width: height
                        enabled: subListModel.count>1
                        icon.color: enabled ? "black" : "grey"
                        icon.source: Data.urls.icons["close"]
                        onClicked: { subListModel.remove(subInd, 1); subListModel.reind() }
                    }

                    placeholderText: subInd
                }
            }
            ToolButton {
                id: addTextEditButton
                height: parent.height
                width: height
                icon.color: enabled ? "black" : "grey"
                icon.source: Data.urls.icons["add"]
                onClicked: subListModel.append({subInd: subListModel.count})
            }
            ToolButton {
                id: closeTextEditButton
                height: parent.height
                width: height
                enabled: listModel.count>1
                icon.color: enabled ? "black" : "grey"
                icon.source: Data.urls.icons["close"]
                onClicked: { listModel.remove(ind, 1); listModel.reind() }
            }
        }
    }
}
