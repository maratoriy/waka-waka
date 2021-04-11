import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12
import Data 1.0
import Backend 1.0
import "components"

Control {
    property var contentObj
    function init() {        
        var taskListObj= contentObj["taskList"]
        swipeView.addItem(pupilDataComponent.createObject(swipeView, {}))
        for(var key in taskListObj) {
            swipeView.addItem(taskComponent.createObject(swipeView, {}))
            swipeView.itemAt(swipeView.count-1).taskObj=taskListObj[key]
            swipeView.itemAt(swipeView.count-1).init()
        }
        swipeView.addItem(endComponent.createObject(swipeView, {}))
        switchHide(false)

        timerLabel.time=contentObj['time']
    }
    function getObj() {
        contentObj['pupil']=swipeView.itemAt(0).surname+' '+swipeView.itemAt(0).name
        contentObj['ptime']=timerLabel.time
        contentObj['type']='result'
        var taskList={}
        let resBasicScore=0
        for(var i=1;i<swipeView.count-1;i++) {
            taskList["task"+i]=swipeView.itemAt(i).getObj()
            resBasicScore+=parseFloat(taskList["task"+i]['question']["score"])
        }
        contentObj['score']=resBasicScore
        return contentObj
    }
    property bool switchHideProp
    function switchHide(val) {
        switchHideProp=val
        swipeView.interactive=val
        indicatorLoader.enabled=val
        decIndButton.enabled=val
        incIndButton.enabled=val
    }

    Control {
        width: parent.width*0.90
        height: parent.height*0.95
        anchors.centerIn: parent
        Control {
            width: parent.width
            height: parent.height* (grid.ori ? 0.85 : 0.75)
            anchors.top: parent.top
            background: Rectangle {
                color: "white"
                radius: 10
            }
            SwipeView {
                id: swipeView
                width: parent.width*0.9
                height: parent.height*0.9
                anchors.centerIn: parent
                Material.theme: Material.Light
                clip: true
            }
            Control {
                height: parent.height*0.05
                width: indicatorLoader.width
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                Label {
                    id: timerLabel
                    property int time
                    color: "black"
                    text: new Date(time*1000).toLocaleTimeString(Qt.locale(), "mm:" + "ss")
                    onTimeChanged: {
                        if(time===0) {
                            switchHideProp=false
                            text="00:00"
                            swipeView.currentIndex=swipeView.count-1
                            swipeView.itemAt(swipeView.count-1).endTask()
                        }
                    }
                    height: parent.height*0.9
                    width: parent.width*0.9
                    anchors.centerIn: parent
                    Timer {
                        id: timer
                        interval: 1000
                        repeat: switchHideProp
                        onTriggered: parent.time-=1
                    }
                }
            }

            Loader {
                id: indicatorLoader
                height: parent.height*0.05
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                sourceComponent: swipeView.count<=30 ? pageIndicator : label
            }
            Component {
                id: pageIndicator
                PageIndicator {
                    count: swipeView.count
                    interactive: true
                    currentIndex: swipeView.currentIndex
                    onCurrentIndexChanged: swipeView.currentIndex=currentIndex
                    Material.theme: Material.Light
                }
            }
            Component {
                id: label
                Row {
                    TextInput {
                        text: (swipeView.currentIndex+1).toString()
                        onTextChanged: swipeView.currentIndex=text-1
                        font.pointSize: root.font.pointSize*1.3
                    }
                    Text {
                        font.pointSize: root.font.pointSize*1.3
                        text: "/"+swipeView.count
                    }
                }
            }
            ToolButton {
                id: decIndButton
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                enabled: swipeView.currentIndex!==0
                icon.source: Data.urls.icons["leftArrow"]
                icon.color: enabled ? "black" : "grey"
                onClicked: swipeView.decrementCurrentIndex()
            }
            ToolButton {
                id: incIndButton
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                enabled: swipeView.currentIndex!==swipeView.count-1
                icon.source: Data.urls.icons["rightArrow"]
                icon.color: enabled ? "black" : "grey"
                onClicked: swipeView.incrementCurrentIndex()
            }
            Component {
                id: pupilDataComponent
                Control {
                    property alias surname: surnameArea.text
                    property alias name: nameArea.text
                    Material.theme: Material.Light
                    Column {
                        anchors.centerIn: parent
                        width: parent.width*0.5
                        height: parent.height*0.2
                        TextField {
                            id: surnameArea
                            placeholderText: Data.names[Data.settings.lang].testpage.surnameplace
                            width: parent.width
                            height: parent.height/2
                            KeyNavigation.tab: nameArea
                        }
                        TextField {
                            id: nameArea
                            placeholderText: Data.names[Data.settings.lang].testpage.nameplace
                            width: parent.width
                            height: parent.height/2
                            focus: true
                            Keys.onPressed: if(event.key===16777220) enterBut.click()
                        }
                    }
                }
            }
            Component {
                id: endComponent
                Control {
                    function endTask() { endButton.endTask() }
                    Column {
                        anchors.fill: parent
                        enabled: swipeView.count>2
                        Button {
                            id: endButton
                            width: parent.width*0.9
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: Data.names[Data.settings.lang].testpage.buttons.endcreate
                            function endTask() {
                                enabled=false
                                switchHide(false)
                                testLabel.text = Backend.toWideString(JSON.stringify(getObj()))
                            }
                            onClicked: endTask()
                            //onClicked: testLabel.text = Backend.toWideString(JSON.stringify(getObj()))
                        }
                        RowLayout {
                            width: parent.width
                            Button {
                                width: parent.width*0.4
                                Layout.alignment: Qt.AlignRight || Qt.AlignVCenter
                                text: Data.names[Data.settings.lang].testpage.buttons.copy
                                enabled: testLabel.text.length!==0
                                onClicked: {
                                    Backend.clipboard.setText(testLabel.text)
                                    testLabel.selectAll()
                                }
                            }
                        }
                        TextArea {
                            id: testLabel
                            width: parent.width
                            height: parent.height*0.7
                            readOnly: true
                            selectByMouse: true
                            wrapMode: TextArea.WrapAnywhere
                        }
                    }
                }
            }
        }
        Control {
            height: parent.height * (grid.ori ? 0.1 : 0.2)
            width: parent.width
            anchors.bottom: parent.bottom
            background: Rectangle {
                color: Data.styles.actions[root.Material.theme]
                radius: 5
            }

            Grid {
                id: grid
                anchors.fill: parent
                property bool ori: root.width>root.height
                rows:    ori ? 1 : 2
                columns: ori ? 2 : 1
                Material.theme: Material.Dark
                ToolButton {
                    width:  parent.width  * (parent.ori ? 0.5 : 1)
                    height: parent.height * (parent.ori ? 1 : 0.5)
                    text: qsTr("Reset")
                    enabled: swipeView.currentIndex!==0 && swipeView.currentIndex!==swipeView.count-1
                    onClicked: swipeView.itemAt(swipeView.currentIndex).reset()
                }
                ToolButton {
                    id: enterBut
                    width:  parent.width  * (parent.ori ? 0.5 : 1)
                    height: parent.height * (parent.ori ? 1 : 0.5)
                    text: qsTr("Enter")
                    enabled: swipeView.currentIndex!==swipeView.count-1
                    onClicked: {
                        if(!switchHideProp) { switchHide(true); timer.start() }
                        swipeView.incrementCurrentIndex()
                    }
                }
            }
        }
    }

    Component {
        id: taskComponent
        TaskComponent {

        }
    }
}
