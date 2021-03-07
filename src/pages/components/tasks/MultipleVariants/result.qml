import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.12
import Data 1.0
import QtQml.Models 2.15

Control {
    property var contentObj
    function init() {
        for(let i=0;i<contentObj['number'];i++) {
            listModel.append({ val: contentObj['panswer'][i]==='1', name: contentObj['variant'+i], ind: listModel.count })
        }
    }
    function obj() {
        var obj=contentObj
        let panswer=""
        for(let i=0;i<listModel.count;i++) {
            panswer+=gridView.itemAtIndex(i).val? "1" : "0"
        }
        obj['panswer']=panswer
        obj['score']=obj['basicScore']*(obj['answer']===obj['panswer'])
        return obj
    }
    Component {
        id: variantComponent
        Row  {
            CheckBox {
                id: cb;
                checked: val
                enabled: false
                //anchors.left: parent.left
            }
            TextArea {
                id: ta;
                text: name
                color: contentObj['answer'][ind]==='1' ? "green" : "black"
                width: gridView.cellWidth-cb.width
                //anchors.right: parent.right;
                wrapMode: TextArea.Wrap;
                readOnly: true
            }
        }
    }
    ListModel {
        id: listModel
    }

    GridView {
        id: gridView
        ScrollBar.vertical: ScrollBar {

        }
        anchors.fill: parent
        cellWidth: width/2
        model: listModel
        clip: true
        delegate: variantComponent
    }
}