import QtQuick 2.12
import QtQuick.Controls 2.12
import Data 1.0
import Backend 1.0
import QtQuick.Controls.Material 2.3

Control {
    property var contentObj
    function init(contentObj) {
        textArea.text=contentObj['answer']
        keywordsArea.text=contentObj['keywords']
    }

    height: childrenRect.height
    function getObj() {
        var obj={
            'answer': textArea.text,
            'keywords': keywordsArea.text
        }
        return obj
    }
    function reset() {
        textArea.clear()
    }
    Column {
        id: column
        width: parent.width
        height: childrenRect.height
        Flickable {
            width: parent.width
            height: Math.min(Math.max(100, textArea.contentHeight+25), 400)
            contentHeight: textArea.height
            boundsBehavior: ListView.StopAtBounds
            ScrollBar.vertical: ScrollBar { id: sb; width: 6; policy: ScrollBar.AlwaysOn}
            TextArea.flickable: TextArea {
                id: textArea
                wrapMode: TextArea.Wrap
                rightInset: sb.width+3
                rightPadding: rightInset
                selectByMouse: true
                placeholderText: Data.names[Data.settings.lang].tasks['TextAnswer'].create.answerplace
                clip: true
            }
        }
        Control {
            height: 60
            topInset: 10
            bottomInset: 10
            width: parent.width
            background: Rectangle {
                radius: 5
                color: Data.styles.actions[Data.settings.theme]
            }
            ToolButton {
                text: Data.names[Data.settings.lang].tasks['TextAnswer'].create.prepbut
                onClicked: keywordsArea.text=Backend.prepareKeywords(textArea.text)
                //rightInset: scrollBar.width
                width: parent.width
                height: parent.height
                Material.theme: Material.Dark
            }
        }
        Flickable {
            width: parent.width
            height: Math.min(Math.max(100, keywordsArea.contentHeight+25), 400)
            clip: true
            TextArea.flickable: TextArea {
                id: keywordsArea
                wrapMode: TextArea.Wrap
                rightInset: sb1.width+3
                rightPadding: rightInset
                selectByMouse: true
                placeholderText: Data.names[Data.settings.lang].tasks['TextAnswer'].create.keyplace
                clip: true
            }
            ScrollBar.vertical: ScrollBar { id: sb1; width: 6; policy: ScrollBar.AlwaysOn}
        }
    }

}
