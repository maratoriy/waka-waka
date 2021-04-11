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

    Flickable {
        height: parent.height
        width: parent.width
        clip: true
        contentHeight: contentItem.childrenRect.height
        boundsBehavior: Flickable.StopAtBounds
        Column {
            width: parent.width
            Flickable {
                id: flick
                width: parent.width
                height: Math.min(Math.max(100, textArea.contentHeight+25), 400)
                TextArea.flickable: TextArea {
                    id: textArea
                    wrapMode: TextArea.Wrap
                    readOnly: true
                    selectByMouse: true
                    placeholderText: Data.names[Data.settings.lang].createpage.taskComponent.question
                }
                ScrollBar.vertical: ScrollBar {}
            }
            Row {
                width: parent.width
                spacing: width*0.1
                TextArea {
                    id: scoreArea
                    width: parent.width*0.4
                    readOnly: true
                    font.pointSize: root.font.pointSize*1.5
                }
                TextArea {
                    id: basicScoreArea
                    width: parent.width*0.4
                    readOnly: true
                    font.pointSize: root.font.pointSize*1.5
                }
            }

            Loader {
                id: loader
                width: parent.width-10
                height : childrenRect.height
            }
        }
    }
}
