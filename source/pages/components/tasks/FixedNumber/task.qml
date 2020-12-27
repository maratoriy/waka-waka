import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.15
import "../../controls"
import Data 1.0

Control {
    id: root
    property var contentObj
    function init() {
        decArea.text=decArea.text+contentObj['decimals']
        valid.decimals= contentObj['decimals']
    }
    function reset() {
    }
    function obj() {
        var obj=contentObj
        obj['panswer']=parseFloat(answerArea.text)
        obj['score']=obj['basicScore']*(check())
        return obj
    }
    function check() {
        return (contentObj['lAnswer']<=answerArea.answer)&&(contentObj['rAnswer']>=answerArea.answer)
    }

    ColumnLayout {
        width: parent.width
        anchors.bottom: parent.bottom
        Label {
            Layout.alignment: Qt.AlignRight
            //readOnly: true
            id: decArea
            text: Data.names[Data.settings.lang].tasks['FixedNumber'].task.decimalplace
        }
        MyTextField {
            id: answerArea
            Layout.fillWidth: true
            property double answer: parseFloat(text)
            placeholderText: Data.names[Data.settings.lang].tasks['FixedNumber'].task.answerplace
            validator: DoubleValidator {
                id: valid
            }
        }
    }
}
