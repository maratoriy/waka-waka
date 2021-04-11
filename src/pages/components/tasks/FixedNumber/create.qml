import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.15
import Data 1.0
import "../../controls"

Control {
    id: root
    function init(contentObj) {
        decSlider.value=contentObj['decimals']
        inacSlider.value=contentObj['inac']
        answerInput.text=contentObj['answer']
    }
    function reset() {
        answerInput.text=''
        inacSlider.value=0
        decInput.value=0
    }
    function getObj() {
        var obj={
            'decimals': Math.round(decSlider.value),
            'inac': inacSlider.value,
            'lAnswer': parseFloat(lAnswer.text),
            'answer': answerInput.answer,
            'rAnswer': parseFloat(rAnswer.text)
        }
        return obj
    }
    Column {
        anchors.fill: parent
        Control {
            width: parent.width
            height: childrenRect.height
            Label {
                anchors.left: parent.left
                text: Data.names[Data.settings.lang].tasks['FixedNumber'].create.decimalsplace+decSlider.value.toFixed(0)
            }
            Slider {
                id: decSlider
                width: parent.width*0.7
                anchors.right: parent.right
                Layout.alignment: Qt.AlignRight
                from: 0
                to: 9
            }
        }
        Control {
            width: parent.width
            height: childrenRect.height
            Label {
                anchors.left: parent.left
                text: Data.names[Data.settings.lang].tasks['FixedNumber'].create.inacplace+(inacSlider.value/100).toFixed(3)
            }
            Slider {
                id: inacSlider
                width: parent.width*0.7
                anchors.right: parent.right
                from: 0
                stepSize: 1
                to: 1000
            }
        }
        RowLayout {
            width: parent.width
            Label {
                text: "Левая граница"
            }
            TextArea {
                id: lAnswer
                Layout.alignment: Qt.AlignRight
                padding: 20
                color: "grey"
                text: (answerInput.answer*(1-inacSlider.value/10000)).toFixed(decSlider.value)
                readOnly: true
            }
        }
        RowLayout {
            width: parent.width
            Label {
                text: "Правая граница"
            }
            TextArea {
                id: rAnswer
                Layout.alignment: Qt.AlignRight
                padding: 20
                color: "grey"
                text: (answerInput.answer*(1+inacSlider.value/10000)).toFixed(decSlider.value)
                readOnly: true
            }
        }
        RowLayout {
            width: parent.width
            Label {
                text: "Ответ"
            }
            TextField {
                padding: 20
                Layout.preferredWidth: rAnswer.width
                Layout.alignment: Qt.AlignRight
                id: answerInput
                property var answer: parseFloat(text.replace(',', '.'))
                placeholderText: Data.names[Data.settings.lang].tasks['FixedNumber'].create.answerplace
                validator: DoubleValidator {
                    decimals: decSlider.value
                }
                text: '0'
                selectByMouse: true
            }
        }


    }
}
