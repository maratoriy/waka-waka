import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.15
import Data 1.0
import "../../controls"

Control {
    id: root
    function init() {

    }
    function reset() {
        answerInput.text=''
        inacSlider.value=0
        decInput.value=0
    }
    function obj() {
        var obj={}
        obj['decimals']=Math.round(decSlider.value)
        obj['inac']=inacSlider.value
        obj['lAnswer']=parseFloat(lAnswer.text)
        obj['answer']=answerInput.answer
        obj['rAnswer']=parseFloat(rAnswer.text)
        return obj
    }
    Column {
        anchors.fill: parent
        RowLayout {
            width: parent.width
            MyTextField {
                padding: 10
                readOnly: true
                text: Data.names[Data.settings.lang].tasks['FixedNumber'].create.decimalsplace
            }
            Slider {
                id: decSlider
                Layout.fillWidth: true
                from: 0
                to: 9
            }
            MyTextField {
                padding: 10
                id: decInput
                text: dec
                property int dec: decSlider.value
                onFocusChanged: decSlider.value=text
                inputMask: '9'
                //placeholderText: qsTr("Decs after point")
            }
        }
        RowLayout {
            width: parent.width
            MyTextField {
                padding: 10
                readOnly: true
                text: Data.names[Data.settings.lang].tasks['FixedNumber'].create.inacplace
            }
            Slider {
                id: inacSlider
                Layout.fillWidth: true
                from: 0
                stepSize: 1
                to: 1000
            }
            MyTextField {
                padding: 10
                id: inacInput
                property var inac: inacSlider.value
                text: inac/100
                onFocusChanged: inacSlider.value=(text-'0')*1000
                DoubleValidator {
                    decimals: 3
                }
            }
        }
        RowLayout {
            anchors.horizontalCenter: parent.horizontalCenter
            MyTextField {
                id: lAnswer
                padding: 20
                text: (answerInput.answer*(1-inacSlider.value/10000)).toFixed(decSlider.value)
                readOnly: true
            }
            Label {
                text: '<='
            }

            MyTextField {
                padding: 20
                id: answerInput
                property var answer: parseFloat(text.replace(',', '.'))
                placeholderText: Data.names[Data.settings.lang].tasks['FixedNumber'].create.answerplace
                validator: DoubleValidator {
                    decimals: decSlider.value
                }
                text: '0'
                selectByMouse: true
            }
            Label {
                text: '<='
            }
            MyTextField {
                id: rAnswer
                padding: 20
                text: (answerInput.answer*(1+inacSlider.value/10000)).toFixed(decSlider.value)
                readOnly: true
            }

        }

    }
}
