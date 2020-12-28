import QtQuick 2.12
import QtQuick.Controls 2.12
import Data 1.0
import Backend 1.0

Control {
    property var contentObj
    function obj() {
        var obj=contentObj
        obj['panswer']=textArea.text
        obj['score']=obj['basicScore']*Backend.checkTextAnswer(obj['panswer'],obj['keywords'])

        return obj
    }
    function init() {

    }
    function reset() {
        textArea.clear()
    }

    Flickable {
        anchors.fill: parent
        TextArea.flickable: TextArea {
            id: textArea
            wrapMode: TextArea.Wrap
            placeholderText: Data.names[Data.settings.lang].tasks['TextAnswer'].task.answerplace
            selectByMouse: true
            clip: true
        }
        ScrollBar.vertical: ScrollBar { }
    }
}
