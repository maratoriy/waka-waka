import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.12
import Data 1.0
import QtQml.Models 2.15

Control {
    function init(contentObj) {
        listModel.clear()
        for(let i=0;i<contentObj['number'];i++)
            listModel.append({value: contentObj['answer'][i]==='1', name: contentObj['variant'+i], ind: i})
    }

    function getObj() {
        let answer=""
        let vars={}
        for(let i=0;i<listModel.count;i++) {
            vars['variant'+i]=gridView.itemAtIndex(i).txt
            answer+=gridView.itemAtIndex(i).val? "1" : "0"
        }
        var obj={
            'number': listModel.count,
            'answer': answer,
        }
        return Object.assign({}, obj, vars)
    }
    function reset() {
        listModel.clear()
        listModel.append({value: false, name: '', ind: 0})
        listModel.append({value: false, name: '', ind: 1})
    }
    height: childrenRect.height
    Component { 
        id: variantComponent
        Row  {
            property alias val: cb.checked
            clip: true
            property alias txt: ta.text

            CheckBox {
                id: cb;
                checked: value
                //anchors.left: parent.left
            }
            Flickable {
                width: gridView.cellWidth-cb.width-deleteVarBut.width
                height: 80
                ScrollBar.vertical: ScrollBar { id: sb; policy: ScrollBar.AlwaysOn; width: 7}
                TextArea.flickable: TextArea {
                    id: ta;
                    rightInset: sb.width+5
                    rightPadding: sb.width+5
                    //anchors.right: parent.right;
                    wrapMode: TextArea.Wrap;
                    placeholderText: Data.names[Data.settings.lang].tasks['MultipleVariants'].create['var']
                    selectByMouse: true
                    text: name
                }
            }
            ToolButton {
                id: deleteVarBut
                width: height
                height: parent.height
                enabled: listModel.count>2
                icon.color: enabled ? "black" : "grey"
                icon.source: Data.urls.icons["close"]
                onClicked: listModel.deleteRow(ind)
            }
        }
    }
    ListModel {
        id: listModel
        function deleteRow(ind) {
            if(count>2) remove(ind,1)
            for(let i=0;i<count;i++) setProperty(i, "ind", i)
        }

        ListElement {
            value: false
            name: ''
            ind: 0
        }
        ListElement {
            value: false
            name: ''
            ind: 1
        }
    }

    GridView {
        id: gridView
        width: parent.width
        height: contentItem.childrenRect.height
        interactive: false
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
                text: Data.names[Data.settings.lang].tasks['MultipleVariants'].create.addvar
                Material.theme: Material.Dark
                width: parent.width
                height: parent.height
                onClicked: listModel.append({ val: false, name: '', ind: listModel.count})
            }
        }
        cellWidth: width/2
        model: listModel
        clip: true
        delegate: variantComponent
    }
}
