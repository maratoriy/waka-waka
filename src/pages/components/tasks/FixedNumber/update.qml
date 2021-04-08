import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.15
import "../../controls"
import Data 1.0

Control {
    id: root
    function init(contentObj) {
        decSlider.value=contentObj['decimals']
        inacSlider.value=contentObj['inac']
        //lAnswer.text=contentObj['lAnswer']
        answerInput.text=contentObj['answer']
        //rAnswer.text=contentObj['rAnswer']
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
            TextField {
                padding: 10
                background: Rectangle {
                    radius: 5
                    border.width: 1
                    border.color: Data.styles.actions[root.Material.theme]
                }

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
                id: inacInput
                readOnly: true
                property var inac: inacSlider.value
                text: inac/100
                onFocusChanged: inacSlider.value=(text-'0')*1000
                DoubleValidator {
                    decimals: 3
                }
                placeholderText: '*****'
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
