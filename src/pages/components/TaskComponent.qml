import QtQuick 2.12
import QtQuick.Controls 2.12
import Data 1.0
import "taskComponents"

Control {
    property var taskObj
    function init() {
        //console.log(JSON.stringify(taskObj))
        questionContent.contentObj=taskObj.questionContent
        questionContent.init()
        loader.source="qrc:/pages/components/tasks/"+taskObj['type']+"/task.qml"
        loader.item.contentObj=taskObj.question
        loader.item.init()
    }
    function obj() {
        taskObj['question']=loader.item.obj()
        return taskObj
    }
    function reset() {
        loader.item.reset()
    }

    QuestionContent {
        id: questionContent
        width: parent.width
        height: parent.height*0.4
        anchors.top: parent.top
    }

    Loader {
        id: loader
        width: parent.width
        height: parent.height*0.475
        anchors.bottom: parent.bottom
    }
}
