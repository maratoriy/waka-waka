import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.15
import Data 1.0

Control {
    id: root
    property var contentObj
    function init() {
        decArea.text=decArea.text+contentObj['decimals']
        inacArea.text=inacArea.text+contentObj['inac']
        answerArea.text+=contentObj['answer']
        panswerArea.text+=contentObj['panswer']
    }
    function reset() {
    }
    function obj() {
        var obj={}
        obj['panswer']=parseFloat(answerArea.text)
        obj['score']=obj['basicScore']*(check())
        return obj
    }
    function check() {
        return (contentObj['lAnswer']<=answerArea.answer)&&(contentObj['rAnswer']>=answerArea.answer)
    }

    Column {
        anchors.fill: parent
        Label {
            id: decArea
            color: "black"
            font.pointSize: root.font.pointSize*1.5
            //readOnly: true
            text: Data.names[Data.settings.lang].tasks['FixedNumber'].result.decimalsplace
        }
        Label {
            id: inacArea
            color: "black"
            font.pointSize: root.font.pointSize*1.5
            //readOnly: true
            text: Data.names[Data.settings.lang].tasks['FixedNumber'].result.inacplace
        }
        Label {
            id: answerArea
            color: "black"
            font.pointSize: root.font.pointSize*1.5
            //readOnly: true
            text: Data.names[Data.settings.lang].tasks['FixedNumber'].result.answerplace
        }
        Label {
            id: panswerArea
            color: "black"
            font.pointSize: root.font.pointSize*1.5
            //readOnly: true
            text: Data.names[Data.settings.lang].tasks['FixedNumber'].result.panswerplace
        }
    }
}
