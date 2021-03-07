import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.12
import Data 1.0
import QtQml.Models 2.15

Control {
    function init() {

    }

    function obj() {
        var obj={}
        obj['number']=listModel.count
        let answer=""
        for(let i=0;i<listModel.count;i++) {
            obj['variant'+i]=gridView.itemAtIndex(i).name
            answer+=gridView.itemAtIndex(i).val? "1" : "0"
        }
        obj['answer']=answer
        console.log(obj)
        return obj
    }
    function reset() {
        listModel.clear()
        listModel.append({val: false, name: '', ind: 0})
        listModel.append({val: false, name: '', ind: 1})
    }
    Component { 
        id: variantComponent
        Row  {
            property alias val: cb.checked
            clip: true
            property alias name: ta.text
            CheckBox {
                id: cb;
                //anchors.left: parent.left
            }
            TextArea {
                id: ta;
                width: gridView.cellWidth-cb.width-deleteVarBut.width
                //anchors.right: parent.right;
                wrapMode: TextArea.Wrap;
                placeholderText: Data.names[Data.settings.lang].tasks['MultipleVariants'].create['var']
                selectByMouse: true
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
            val: false
            name: ''
            ind: 0
        }
        ListElement {
            val: false
            name: ''
            ind: 1
        }
    }

    GridView {
        id: gridView
        ScrollBar.vertical: ScrollBar {

        }
        header: ToolButton {
            text: Data.names[Data.settings.lang].tasks['MultipleVariants'].create.addvar
            Material.theme: Material.Dark
            background: Rectangle {
                radius: 5
                color: Data.styles.actions[root.Material.theme]
            }
            width: parent.width
            onClicked: listModel.append({ val: false, name: ' ', ind: listModel.count})
        }
        anchors.fill: parent
        cellWidth: width/2
        model: listModel
        clip: true
        delegate: variantComponent
    }
}
