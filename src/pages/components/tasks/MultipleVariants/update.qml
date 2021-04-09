import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.12
import Data 1.0
import QtQml.Models 2.15

Control {
    function init(contentObj) {
        for(let i=0;i<contentObj['number'];i++)
            listModel.append({val: contentObj['answer'][i]==='1', name: contentObj['variant'+i], ind: i})
    }

    function obj() {
        var obj={}
        obj['number']=listModel.count
        let answer=""
        for(let i=0;i<listModel.count;i++) {
            obj['variant'+i]=gridView.itemAtIndex(i).t.text
            answer+=gridView.itemAtIndex(i).c.checked? "1" : "0"
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
            property alias c: cb
            clip: true
            property alias t: ta
            CheckBox {
                id: cb;
                checked: val
                //anchors.left: parent.left
            }
            Flickable {
                width: gridView.cellWidth-cb.width-deleteVarBut.width
                height: 80
                ScrollBar.vertical: ScrollBar { id: sb; policy: ScrollBar.AlwaysOn}
                TextArea.flickable: TextArea {
                    id: ta;
                    rightInset: sb.width+5
                    rightPadding: sb.width+5
                    //anchors.right: parent.right;
                    wrapMode: TextArea.Wrap;
                    text: name
                    placeholderText: Data.names[Data.settings.lang].tasks['MultipleVariants'].create['var']
                    selectByMouse: true
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
    }

    GridView {
        id: gridView
        ScrollBar.vertical: ScrollBar {
            id: sb
            policy: ScrollBar.AlwaysOn
        }
        header: ToolButton {
            text: Data.names[Data.settings.lang].tasks['MultipleVariants'].create.addvar
            Material.theme: Material.Dark
            background: Rectangle {
                radius: 5
                color: Data.styles.actions[root.Material.theme]
            }
            width: parent.width-sb.width-5
            onClicked: listModel.append({ val: false, name: ' ', ind: listModel.count})
        }
        anchors.fill: parent
        cellWidth: width/2
        model: listModel
        clip: true
        delegate: variantComponent
    }
}
