import QtQuick 2.12
import QtQuick.Controls 2.12
import Data 1.0
import QtQuick.Controls.Material 2.12
import "controls"

Control {
    function obj() {
        var _obj={}
        let __obj={}
        __obj['text']=textArea.text
        _obj['questionContent']=__obj
        _obj['type']=Data.typeList[comboBox.currentIndex]
        _obj['question']=loader.item.obj()
        _obj['question']['basicScore']=parseInt(basicScoreArea.text)
        return _obj
    }
    function reset() {
        textArea.clear()
        loader.item.reset()
    }

    Column {
        anchors.fill: parent
        Flickable {
            id: flick
            width: parent.width
            height: parent.height*0.3
            TextArea.flickable: TextArea {
                id: textArea
                wrapMode: TextArea.Wrap
                selectByMouse: true
                placeholderText: Data.names[Data.settings.lang].createpage.taskComponent.question
            }
            ScrollBar.vertical: ScrollBar {}
        }
        Row {
            width: parent.width
            height: parent.height*0.1
            spacing: width*0.1
            leftPadding: width/50
            ComboBox {
                id: comboBox
                width: parent.width*0.4
                model: Data.names[Data.settings.lang].createpage.taskComponent.typeList
                Material.theme: Material.Light
                onCurrentIndexChanged:
                    loader.source="qrc:/pages/components/tasks/"+Data.typeList[currentIndex]+"/create.qml"
            }
            MyTextField {
                id: basicScoreArea
                width: parent.width*0.4
                height: parent.height
                validator: IntValidator {

                }
                placeholderText: Data.names[Data.settings.lang].createpage.taskComponent.basicscore
                horizontalAlignment: TextArea.AlignLeft
                font.pointSize: root.font.pointSize*1.5
            }
        }

        Loader {
            id: loader
            width: parent.width
            height: parent.height*0.5
        }
    }
    property alias area: textArea.text

}
