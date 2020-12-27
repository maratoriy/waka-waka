import QtQuick 2.12
import QtQuick.Controls 2.12
import Data 1.0

Control {
    property var contentObj
    function obj() {
       var obj=contentObj
       obj["panswer"] = cb1.v+cb2.v+cb3.v+cb4.v
       obj["score"]   = (obj["panswer"]===obj["answer"])*obj["basicScore"]
       return obj
    }
    function init() {

    }

    Grid {
        anchors.fill: parent
        columns: 2
        rows: 2
        CheckBox { id: cb1; property string v: checked?"1":"0"; width: parent.width/2; height: parent.height/2; text: contentObj["cb1"] }
        CheckBox { id: cb2; property string v: checked?"1":"0"; width: parent.width/2; height: parent.height/2; text: contentObj["cb2"] }
        CheckBox { id: cb3; property string v: checked?"1":"0"; width: parent.width/2; height: parent.height/2; text: contentObj["cb3"] }
        CheckBox { id: cb4; property string v: checked?"1":"0"; width: parent.width/2; height: parent.height/2; text: contentObj["cb4"] }
    }
}
