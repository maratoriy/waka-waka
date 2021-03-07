import QtQuick 2.14
import QtQuick.Controls 2.12
import Data 1.0

Control {
    property var contentObj
    function init() {
        cb1.checked=contentObj['panswer'][0]==='1'
        cb2.checked=contentObj['panswer'][1]==='1'
        cb3.checked=contentObj['panswer'][2]==='1'
        cb4.checked=contentObj['panswer'][3]==='1'
        ta1.color  =contentObj['answer'][0]==='1' ? "green" : "black"
        ta2.color  =contentObj['answer'][1]==='1' ? "green" : "black"
        ta3.color  =contentObj['answer'][2]==='1' ? "green" : "black"
        ta4.color  =contentObj['answer'][3]==='1' ? "green" : "black"
        ta1.text   =contentObj['cb1']
        ta2.text   =contentObj['cb2']
        ta3.text   =contentObj['cb3']
        ta4.text   =contentObj['cb4']
    }

    Grid {
        anchors.fill: parent
        columns: 2
        rows: 2
        Control  { width: parent.width/2; height: parent.height/2; CheckBox { id: cb1; enabled: false; property var v: checked ? "1" : "0"; anchors.left: parent.left } TextArea { id: ta1; width: parent.width-cb1.width; readOnly: true; anchors.right: parent.right; wrapMode: TextArea.Wrap; placeholderText: qsTr("Variant1")} }
        Control  { width: parent.width/2; height: parent.height/2; CheckBox { id: cb2; enabled: false; property var v: checked ? "1" : "0"; anchors.left: parent.left } TextArea { id: ta2; width: parent.width-cb2.width; readOnly: true; anchors.right: parent.right; wrapMode: TextArea.Wrap; placeholderText: qsTr("Variant2")} }
        Control  { width: parent.width/2; height: parent.height/2; CheckBox { id: cb3; enabled: false; property var v: checked ? "1" : "0"; anchors.left: parent.left } TextArea { id: ta3; width: parent.width-cb3.width; readOnly: true; anchors.right: parent.right; wrapMode: TextArea.Wrap; placeholderText: qsTr("Variant3")} }
        Control  { width: parent.width/2; height: parent.height/2; CheckBox { id: cb4; enabled: false; property var v: checked ? "1" : "0"; anchors.left: parent.left } TextArea { id: ta4; width: parent.width-cb4.width; readOnly: true; anchors.right: parent.right; wrapMode: TextArea.Wrap; placeholderText: qsTr("Variant4")} }

    }
}
