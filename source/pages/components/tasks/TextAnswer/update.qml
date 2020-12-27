import QtQuick 2.12
import QtQuick.Controls 2.12
import Data 1.0
import Backend 1.0

Control {
    property var contentObj
    function init(contentObj) {
        textArea.text=contentObj['answer']
        keywordsArea.text=contentObj['keywords']
    }

    function obj() {
        var _obj={}
        _obj['answer']=textArea.text
        _obj['keywords']=keywordsArea.text
        return _obj
    }
    function reset() {
        textArea.clear()
    }
    Column {
        anchors.fill: parent
        Flickable {
            width: parent.width
            height: parent.height*0.60
            TextArea.flickable: TextArea {
                id: textArea
                wrapMode: TextArea.Wrap
                selectByMouse: true
                placeholderText: Data.names[Data.settings.lang].tasks['TextAnswer'].create.answerplace
                clip: true
            }
            ScrollBar.vertical: ScrollBar { }
        }
        Button {
            width: parent.width
            height: parent.height*0.2
            text: Data.names[Data.settings.lang].tasks['TextAnswer'].create.prepbut
            onClicked: keywordsArea.text=Backend.prepareKeywords(textArea.text)
        }
        Flickable {
            width: parent.width
            height: parent.height*0.2
            TextArea.flickable: TextArea {
                id: keywordsArea
                wrapMode: TextArea.Wrap
                selectByMouse: true
                placeholderText: Data.names[Data.settings.lang].tasks['TextAnswer'].create.keyplace
                clip: true
            }
            ScrollBar.vertical: ScrollBar { }
        }
    }

}
