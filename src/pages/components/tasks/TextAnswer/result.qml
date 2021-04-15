import QtQuick 2.14
import QtQuick.Controls 2.12
import Data 1.0

Control {
    property var contentObj
    function init() {
        panswerArea.text=contentObj['panswer']
        answerArea.visible=contentObj['showAnswer']===true
        answerArea.text=contentObj['answer']
    }
    height: childrenRect.height
    Column {
        width: parent.width
        height: childrenRect.height
        spacing: width*0.05
        Flickable {
            width: parent.width
            boundsBehavior: ListView.StopAtBounds
            height: Math.min(Math.max(100, answerArea.contentHeight+25), 400)
            TextArea.flickable: TextArea {
                id: answerArea
                wrapMode: TextArea.Wrap
                readOnly: true
                rightInset: sb1.width
                selectByMouse: true
                clip: true
            }
            ScrollBar.vertical: ScrollBar { id: sb1; width: 5; }
        }
        Flickable {
            width: parent.width
            boundsBehavior: ListView.StopAtBounds
            height: Math.min(Math.max(100, panswerArea.contentHeight+25), 400)
            TextArea.flickable: TextArea {
                id: panswerArea
                wrapMode: TextArea.Wrap
                selectByMouse: true
                rightInset: sb2.width
                readOnly: true
                clip: true
            }
            ScrollBar.vertical: ScrollBar { id: sb2; width: 5; }
        }
    }

}
