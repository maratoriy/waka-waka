import QtQuick 2.14
import QtQuick.Controls 2.12

Control {
    property var contentObj
    function init() {
        panswerArea.text=contentObj['panswer']
        answerArea.text=contentObj['answer']
    }
    Column {
        anchors.fill: parent
        spacing: width*0.05
        Flickable {
            width: parent.width
            height: parent.height*0.475
            TextArea.flickable: TextArea {
                id: panswerArea
                wrapMode: TextArea.Wrap
                selectByMouse: true
                readOnly: true
                clip: true
            }
            ScrollBar.vertical: ScrollBar { }
        }
        Flickable {
            width: parent.width
            height: parent.height*0.475
            TextArea.flickable: TextArea {
                id: answerArea
                wrapMode: TextArea.Wrap
                selectByMouse: true
                readOnly: true
                clip: true
            }
            ScrollBar.vertical: ScrollBar { }
        }
    }

}
