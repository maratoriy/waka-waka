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
    function getObj() {
    }

    height: childrenRect.height
    Column {
        width: parent.width
        height: childrenRect.height
        Label {
            id: decArea
            color: "black"
            //readOnly: true
            text: Data.names[Data.settings.lang].tasks['FixedNumber'].result.decimalsplace
        }
        Label {
            id: inacArea
            color: "black"
            //readOnly: true
            text: Data.names[Data.settings.lang].tasks['FixedNumber'].result.inacplace
        }
        Label {
            id: answerArea
            color: "black"
            visible: contentObj['showAnswer']===1
            //readOnly: true
            text: Data.names[Data.settings.lang].tasks['FixedNumber'].result.answerplace
        }
        Label {
            id: panswerArea
            color: "black"
            //readOnly: true
            text: Data.names[Data.settings.lang].tasks['FixedNumber'].result.panswerplace
        }
    }
}
