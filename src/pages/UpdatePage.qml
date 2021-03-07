import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.14
import QtQuick.Layouts 1.12

import "components"
import Data 1.0
import Backend 1.0

Page  {
    id: root
    function init(obj) {
        swipeView.addItem(headerComponent.createObject(swipeView, {}))
        let buf=swipeView.itemAt(0)
        buf.name=obj['name']
        buf.time=obj['time']
        buf.password=obj['password']
        swipeView.addItem(endComponent.createObject(swipeView, {}))

        //доб-ие заданий
        for(let key in obj['taskList']) {
            swipeView.insertItem(swipeView.count-1, createTaskComponent.createObject(swipeView, {}))
            swipeView.itemAt(swipeView.count-2).init(obj['taskList'][key])
        }
    }
    function makeObj() {
        var obj={}
        obj['name']= swipeView.itemAt(0).name
        obj['time']= Math.round(swipeView.itemAt(0).time)
        obj['password']= swipeView.itemAt(0).password
        obj['type']="blank"
        obj['count']=swipeView.count-2
        let resBasicScore=0
        var taskList={}
        for(var i=1;i<swipeView.count-1;i++) {
            taskList["task"+i]=swipeView.itemAt(i).obj()
            resBasicScore+=taskList["task"+i]['question']["basicScore"]
        }
        obj['taskList']=taskList
        obj['basicScore']=resBasicScore
        return obj
    }

    Control {
        width: parent.width*0.90
        height: parent.height*0.90
        anchors.centerIn: parent
        Control {
            width: parent.width
            height: parent.height* (grid.ori ? 0.85 : 0.65)
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
            ToolButton {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                enabled: swipeView.currentIndex!==0
                icon.source: Data.urls.icons["leftArrow"]
                icon.color: enabled ? "black" : "grey"
                onClicked: swipeView.decrementCurrentIndex()
            }
            ToolButton {
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                enabled: swipeView.currentIndex!==swipeView.count-1
                icon.source: Data.urls.icons["rightArrow"]
                icon.color: enabled ? "black" : "grey"
                onClicked: swipeView.incrementCurrentIndex()
            }
            Loader {
                height: parent.height*0.05
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                sourceComponent: swipeView.count<=30 ? pageIndicator : label
            }
            ToolButton {
                id: keyboardButton
                Material.theme: Material.Dark
                text: Data.names[Data.settings.lang].createpage.buttons.symbkeyboard
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                onClicked: {
                    dialog.visible=!dialog.visible
                    dialog.x=0
                    dialog.y=0
                }
                background: Rectangle {
                    radius: 5
                    color: Data.styles.actions[root.Material.theme]
                }
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

            Component {
                id: createTaskComponent
                UpdateTaskComponent {

                }
            }

            Component {
                id: headerComponent
                Control {
                    property alias name: textArea.text
                    property alias time: slider.value
                    property alias password: passwordInput.text
                    Column {
                        anchors.fill: parent
                        TextArea {
                            id: textArea
                            width: parent.width
                            selectByMouse: true
                            placeholderText: Data.names[Data.settings.lang].createpage.main.testname
                            clip: true
                        }
                        Row {
                            width: parent.width
                            spacing: width-testNameInput.contentWidth-slider.width-40
                            Slider {
                                id: slider
                                from: 0
                                value: 600
                                to: 3599
                                stepSize: 30
                                width: parent.width*0.9
                            }
                            TextField {
                                id: testNameInput
                                background: Rectangle {
                                    radius: 5
                                    border.width: 1
                                    border.color: Data.styles.actions[root.Material.theme]
                                }
                                padding: 20
                                selectByMouse: true
                                horizontalAlignment: TextInput.AlignHCenter
                                verticalAlignment: TextInput.AlignVCenter
                                property int time: slider.value
                                onTimeChanged: text= new Date(time*1000).toLocaleTimeString(Qt.locale(), "mm:" + "ss")
                                onFocusChanged: slider.value=text.charAt(0)*600+text.charAt(1)*60+text.charAt(3)*10+text.charAt(4)*1
                                inputMask: "99:99"
                                font.pointSize: root.font.pointSize*1.5
                            }
                        }
                        TextArea {
                            id: passwordInput
                            width: parent.width
                            selectByMouse: true
                            font.pointSize: root.font.pointSize*1.1
                            placeholderText: Data.names[Data.settings.lang].createpage.main.password
                        }
                    }
                }
            }
            Component {
                id: endComponent
                Control {
                    Column {
                        anchors.fill: parent
                        enabled: swipeView.count>2
                        Button {
                            width: parent.width*0.9
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: Data.names[Data.settings.lang].createpage.buttons.create
                            //onClicked: testLabel.text = JSON.stringify(makeObj())
                            onClicked: testLabel.text = Backend.toWideString(JSON.stringify(makeObj()))
                        }
                        RowLayout {
                            width: parent.width
                            Button {
                                width: parent.width*0.4
                                Layout.alignment: Qt.AlignRight || Qt.AlignVCenter
                                text: Data.names[Data.settings.lang].createpage.buttons.copy
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
            height: parent.height * (grid.ori ? 0.1 : 0.3)
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
                rows:    ori ? 1 : 3
                columns: ori ? 3 : 1
                Material.theme: Material.Dark
                ToolButton {
                    width:  parent.width  * (parent.ori ? 0.33 : 1)
                    height: parent.height * (parent.ori ? 1 : 0.33)
                    text: Data.names[Data.settings.lang].createpage.buttons['delete']
                    enabled: swipeView.currentIndex!==0 && swipeView.currentIndex!==swipeView.count-1
                    onClicked: swipeView.removeItem(swipeView.itemAt(swipeView.currentIndex))
                }
                ToolButton {
                    width:  parent.width  * (parent.ori ? 0.33 : 1)
                    height: parent.height * (parent.ori ? 1 : 0.33)
                    text: Data.names[Data.settings.lang].createpage.buttons.reset
                    enabled: swipeView.currentIndex!==0 && swipeView.currentIndex!==swipeView.count-1
                    onClicked: swipeView.itemAt(swipeView.currentIndex).reset()
                }
                ToolButton {
                    width:  parent.width  * (parent.ori ? 0.33 : 1)
                    height: parent.height * (parent.ori ? 1 : 0.33)
                    text: Data.names[Data.settings.lang].createpage.buttons.add
                    onClicked: {
                        swipeView.insertItem(swipeView.count-1, createTaskComponent.createObject(swipeView, {}))
                        swipeView.setCurrentIndex(swipeView.count-2)
                    }
                }
            }
        }
    }
    Control {
        id: dialog
        width: parent.width*0.2
        height: parent.height*0.5
        visible: false
        background: Rectangle {
            //radius: 5
            color: root.Material.theme===Material.Light ? 'white' : '#303030'
        }
        Column {
            anchors.fill: parent
            Rectangle {
                height: 30
                //radius: 5
                width: parent.width
                color: Data.styles.actions[root.Material.theme]
                MouseArea {
                    id: dragArea
                    anchors.fill: parent
                    property int previousX
                    property int previousY
                    onPressed: {
                        previousX = mouseX
                        previousY = mouseY
                    }
                    onMouseXChanged: {
                        var dx = mouseX - previousX
                        dialog.x=(dialog.x + dx)
                    }
                    onMouseYChanged: {
                        var dy = mouseY - previousY
                        dialog.y=(dialog.y + dy)
                    }
                }
                ToolButton {
                    width: height
                    height: parent.height
                    anchors.right: parent.right
                    icon.color: "white"
                    icon.source: Data.urls.icons["close"]
                    onClicked: dialog.visible=false
                }
            }
            Control {
                width: parent.width
                height: parent.height-30
                GridView {
                    anchors.fill: parent
                    id: gridView
                    clip: true
                    model: Data.symbols
                    cellHeight: 30
                    cellWidth: 30
                    delegate: Control {
                        width: gridView.cellWidth
                        height: gridView.cellHeight
                        Layout.alignment: Qt.AlignCenter
                        ToolButton {
                            contentItem: Text {
                                text: modelData
                                color: root.Material.theme===Material.Dark ? (parent.down ? "#AFAFAF" : "#FFFFFF") : (parent.down ? "grey" : "#000000")
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                font.pointSize: root.font.pointSize*1.2
                            }

                            anchors.centerIn: parent
                            onClicked: Backend.clipboard.setText(modelData)
                        }
                    }
                }
            }
        }
    }
}

