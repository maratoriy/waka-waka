import QtQuick 2.12
import QtQuick.Controls 2.12
import Data 1.0
import "taskComponents"

Control {
    property var taskObj
    function init() {
        questionContent.contentObj=taskObj.questionContent
        questionContent.init()
        loader.source="qrc:/pages/components/tasks/"+taskObj['type']+"/task.qml"

        loader.item.contentObj=taskObj.question
        loader.item.init()
    }
    function getObj() {
        taskObj['question']=loader.item.getObj();
        return taskObj
    }
    function reset() {
        loader.item.reset()
    }
    Flickable {
        height: parent.height
        width: parent.width
        clip: true
        contentHeight: contentItem.childrenRect.height
        boundsBehavior: Flickable.StopAtBounds
        ScrollBar.vertical: ScrollBar {
            id: sb
            width: 7
            policy: ScrollBar.AlwaysOn
        }
        QuestionContent {
            id: questionContent
            width: parent.width-10
            anchors.top: parent.top
        }

        Loader {
            id: loader
            anchors.top: questionContent.bottom
            width: parent.width-10
            height : childrenRect.height
        }
    }
}
