import QtQuick 2.12
import QtQuick.Controls 2.12

Control {
    property var contentObj
    function init() {
        textArea.text=contentObj['text']
    }

    height: childrenRect.height
    function getObj() {
        var obj={
            'text': textArea.text,
            'score': 0
        }
        return obj
    }
    function reset() {
        textArea.clear()
    }
    Flickable {
        width: parent.width
        height: Math.min(Math.max(300, textArea.contentHeight+25), 700)
        contentHeight: textArea.height
        boundsBehavior: ListView.StopAtBounds
        ScrollBar.vertical: ScrollBar { id: sb; width: 6; policy: ScrollBar.AlwaysOn}
        TextArea.flickable: TextArea {
            id: textArea
            wrapMode: TextArea.Wrap
            rightInset: sb.width+3
            rightPadding: rightInset
            selectByMouse: true
            readOnly: true
            clip: true
        }
    }
}
