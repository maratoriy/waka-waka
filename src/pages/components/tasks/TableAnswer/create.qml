import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.12
import Data 1.0
import QtQml.Models 2.15

Control {
    height: listView.height
    function init(contentObj) {
        listModel.clear()
        for(let i=0;i<contentObj['number'];i++) {
            let nod=contentObj['nods']['nod'+i]
            listModel.append(makeNod(i,nod['name'],nod['subNods']))
        }
    }
    function getObj() {
        let subObj={}
        for(let i=0;i<listView.count;i++) {
            let nod={
                'name': listView.itemAtIndex(i)._nod,
                'subNods': listView.itemAtIndex(i).getSubNods()
            }
            subObj['nod'+i]=nod
        }
        var obj={
            'number': listView.count,
            'nods': subObj
        }
        return obj
    }
    function makeNod(i,n,s) {
        return {ind: i, nod: n, subNods: s}
    }
    function reset() {
        listModel.clear()
        listModel.append({ind: 0, nod: 'привет'})
    }
    Component.onCompleted: listModel.append(makeNod(0,'',{}))
    ListModel {
        id: listModel
        function reind() {
            for(let i=0;i<count;i++) setProperty(i, 'ind', i)
        }
    }

    ListView {
        id: listView
        width: parent.width
        model: listModel
        interactive: false
        height: contentItem.childrenRect.height
        //ScrollBar.vertical: ScrollBar { id: scrollBar; width: 5 }
        header: Control {
            height: 60
            topInset: 10
            bottomInset: 10
            width: parent.width
            background: Rectangle {
                radius: 5
                color: Data.styles.actions[root.Material.theme]
            }
            ToolButton {
                text: Data.names[Data.settings.lang].tasks['TableAnswer'].create.addnod
                Material.theme: Material.Dark
                //rightInset: scrollBar.width
                width: parent.width
                height: parent.height
                onClicked: listModel.append(makeNod(listModel.count,'',{}))
            }
        }
        spacing: 10
        delegate: Row {
            width: listView.width
            height: 60
            topPadding: height/10
            Component.onCompleted: initNod()
            property string _nod: mainTextEdit.text
            function makeSubNod(i,s) {
                return {subInd: i, subNod: s}
            }
            function initNod() {
                if(subNods['number']>0) {
                    subListModel.clear()
                    for(let i=0;i<subNods['number'];i++) {
                        subListModel.append(makeSubNod(i,subNods['subNod'+i]))
                    }
                } else {
                    subListModel.append(makeSubNod(0,''))
                }
            }
            function getSubNods() {
                let obj={ 'number': subListView.count}
                for(let i=0;i<subListView.count;i++)
                    obj['subNod'+i]=subListView.itemAtIndex(i).text
                return obj
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
                text: nod
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
                width: parent.width-mainTextEdit.width-addTextEditButton.width*2-separator.width//-scrollBar.width
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
                    placeholderText: subInd
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
                onClicked: subListModel.append(makeSubNod(subListModel.count,''))
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
