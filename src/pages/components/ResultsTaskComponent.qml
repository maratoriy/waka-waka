import QtQuick 2.12
import QtQuick.Controls 2.12
import Data 1.0
import QtQuick.Controls.Material 2.12

Control {
    id: root
    function init(taskObj) {
        textArea.text=taskObj['questionContent']['text']
        scoreArea.text=taskObj['question']['score']
        basicScoreArea.text=taskObj['question']['basicScore']
        loader.source="tasks/"+taskObj['type']+"/result.qml"
        loader.item.contentObj=taskObj['question']
        loader.item.init()
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
                readOnly: true
            }
            ScrollBar.vertical: ScrollBar {}
        }
        Row {
            width: parent.width
            height: parent.height*0.1
            spacing: width*0.1
            TextArea {
                id: scoreArea
                width: parent.width*0.4
                height: parent.height
                readOnly: true
                font.pointSize: root.font.pointSize*1.5
            }
            TextArea {
                id: basicScoreArea
                width: parent.width*0.4
                height: parent.height
                readOnly: true
                font.pointSize: root.font.pointSize*1.5
            }
        }

        Loader {
            id: loader
            width: parent.width
            height: parent.height*0.5
        }
    }
}
