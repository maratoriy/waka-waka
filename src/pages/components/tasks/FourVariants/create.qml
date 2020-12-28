import QtQuick 2.14
import QtQuick.Controls 2.12
import Data 1.0

Control {
    function init(contentObj) {
        cb1.checked=contentObj['answer'][0]==='1'
        cb2.checked=contentObj['answer'][1]==='1'
        cb3.checked=contentObj['answer'][2]==='1'
        cb4.checked=contentObj['answer'][3]==='1'
        ta1.text   =contentObj['cb1']
        ta2.text   =contentObj['cb2']
        ta3.text   =contentObj['cb3']
        ta4.text   =contentObj['cb4']
    }

    function obj() {
        let _obj={}
        _obj['cb1']   =ta1.text
        _obj['cb2']   =ta2.text
        _obj['cb3']   =ta3.text
        _obj['cb4']   =ta4.text
        _obj['answer']= cb1.v+cb2.v+cb3.v+cb4.v
        return _obj
    }
    function reset() {
        ta1.clear()
        ta2.clear()
        ta3.clear()
        ta4.clear()
        cb1.checked=false
        cb2.checked=false
        cb3.checked=false
        cb4.checked=false
    }

    Grid {
        anchors.fill: parent
        columns: 2
        rows: 2
        Control  { width: parent.width/2; height: parent.height/2; CheckBox { id: cb1; property var v: checked ? "1" : "0"; anchors.left: parent.left } TextArea { id: ta1; width: parent.width-cb1.width; anchors.right: parent.right; wrapMode: TextArea.Wrap; placeholderText: qsTr("Variant1")} }
        Control  { width: parent.width/2; height: parent.height/2; CheckBox { id: cb2; property var v: checked ? "1" : "0"; anchors.left: parent.left } TextArea { id: ta2; width: parent.width-cb2.width; anchors.right: parent.right; wrapMode: TextArea.Wrap; placeholderText: qsTr("Variant2")} }
        Control  { width: parent.width/2; height: parent.height/2; CheckBox { id: cb3; property var v: checked ? "1" : "0"; anchors.left: parent.left } TextArea { id: ta3; width: parent.width-cb3.width; anchors.right: parent.right; wrapMode: TextArea.Wrap; placeholderText: qsTr("Variant3")} }
        Control  { width: parent.width/2; height: parent.height/2; CheckBox { id: cb4; property var v: checked ? "1" : "0"; anchors.left: parent.left } TextArea { id: ta4; width: parent.width-cb4.width; anchors.right: parent.right; wrapMode: TextArea.Wrap; placeholderText: qsTr("Variant4")} }

    }
}
