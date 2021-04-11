import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.12
import Data 1.0
import QtQml.Models 2.15

Control {
    property var contentObj
    function init() {
        for(let i=0;i<contentObj['number'];i++) {
            listModel.append({ name: contentObj['variant'+i], ind: i })
        }
    }
    function getObj() {
        let panswer=""
        for(let i=0;i<listModel.count;i++) {
            panswer+=gridView.itemAtIndex(i).val? "1" : "0"
        }
        var obj= Object.assign({},
                               contentObj,
                               {
                                   'panswer': panswer,
                                   'score': contentObj['basicScore']*(contentObj['answer']===panswer)
                               })
        return obj
    }
    function reset() {
        for(let i=0;i<listModel.count; i++)
            gridView.itemAtIndex(i).val=false
    }
    height: childrenRect.height
    Component {
        id: variantComponent
        Row  {
            property alias val: cb.checked
            CheckBox {
                id: cb;
                //anchors.left: parent.left
            }
            Flickable {
                width: gridView.cellWidth-cb.width
                height: 80
                ScrollBar.vertical: ScrollBar { id: sb; policy: ScrollBar.AlwaysOn; width: 3}
                TextArea.flickable: TextArea {
                    id: ta;
                    rightInset: sb.width+5
                    rightPadding: sb.width+5
                    //anchors.right: parent.right;
                    wrapMode: TextArea.Wrap;
                    text: name
                    readOnly: true
                    placeholderText: Data.names[Data.settings.lang].tasks['MultipleVariants'].create['var']
                    selectByMouse: true
                }
            }
        }
    }
    ListModel {
        id: listModel
    }

    GridView {
        id: gridView
        height: contentItem.childrenRect.height
        width: parent.width
        cellWidth: width/2
        model: listModel
        clip: true
        delegate: variantComponent
    }
}
