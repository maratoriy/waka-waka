import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.12
import Data 1.0
import QtQml.Models 2.15

Control {
    property var contentObj
    height: listView.height
    function init() {
        for(let i=0;i<contentObj['number'];i++) {
            let nod=contentObj['nods']['nod'+i]
            listModel.append({ind: i, nod: nod['name']})
        }
    }
    function reset() {
        for(let i=0;i<listView.count;i++) {
            listView.itemAtIndex(i).subListMod.clear()
            listView.itemAtIndex(i).subListMod.append({subInd: 0})
        }
    }
    function getObj() {
        let subObj={}
        for(let i=0;i<listView.count;i++) {
            let subNods={
                'number': listView.itemAtIndex(i).subList.count
            }
            for(let j=0;j<listView.itemAtIndex(i).subList.count;j++) {
                subNods['subNod'+j]=listView.itemAtIndex(i).subList.itemAtIndex(j).text
            }
            let nod={
                'name': listView.itemAtIndex(i).nod,
                'subNods': subNods
            }
            subObj['nod'+i]=nod
        }
        var obj= Object.assign({}, contentObj, {
            'number': listView.count,
            'pnods': subObj
        })
        obj['score']=(obj['basicScore']*answer(obj)).toFixed(1)
        return obj
    }
    function answer(obj) {
        let k=0.00,pk=0.00
        for(let i=0;i<obj['number'];i++) {
            let nod=obj['nods']['nod'+i]['subNods']
            let pnod=obj['pnods']['nod'+i]['subNods']
            let str=[], pstr=[]
            for(let j=0;j<nod['number'];j++,k++) str.push(nod['subNod'+j])
            for(let j=0;j<pnod['number'];j++) pstr.push(pnod['subNod'+j])
            for(let j=0;j<pstr.length;j++) if(str.includes(pstr[j])) { str.splice(str.indexOf(pstr[j]),1); pk++ }
        }
        return pk/k
    }

    ListModel {
        id: listModel
    }

    ListView {
        id: listView
        width: parent.width
        model: listModel
        clip: true
        height: contentItem.childrenRect.height
        ScrollBar.vertical: ScrollBar { id: scrollBar; width: 5 }
//        header: ToolButton {
//            text: qsTr("Add row")
//            Material.theme: Material.Dark
//            rightInset: scrollBar.width
//            background: Rectangle {
//                radius: 5
//                color: Data.styles.actions[root.Material.theme]
//            }
//            width: parent.width
//            onClicked: listModel.append({ind: listModel.count})
//        }
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
                function reind() {
                    for(let i=0;i<count;i++) setProperty(i, 'subInd', i)
                }
                ListElement {
                    subInd: 0
                }
            }
            ListView {
                id: subListView
                width: parent.width-mainTextEdit.width-addTextEditButton.width-separator.width-scrollBar.width
                height: parent.height
                clip: true
                orientation: Qt.Horizontal
                model: subListModel
                spacing: width/50
                ScrollBar.horizontal: ScrollBar { id: subScrollBar }
                delegate: TextField {
//                    readOnly: true
                    padding: 20
                    bottomInset: subScrollBar.height*0.25
                    rightPadding: subCloseTextEditButton.width+20
                    selectByMouse: true
                    placeholderText: subInd
                    background: Rectangle {
                        radius: 15
                        border.color: Data.styles.actions[root.Material.theme]
                        border.width: 1
                    }
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
//            ToolButton {
//                id: closeTextEditButton
//                height: parent.height
//                width: height
//                enabled: listModel.count>1
//                icon.color: enabled ? "black" : "grey"
//                icon.source: Data.urls.icons["close"]
//                onClicked: listModel.remove(ind, 1)
//            }
        }
    }
}
