import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.14
import QtQuick.Layouts 1.12

import "components"
import "components/taskComponents"
import Data 1.0
import Backend 1.0

Page  {
    id: root
    function init(f, obj) {
        switch(f) {
        case "create": {
            swipeView.addItem(headerComponent.createObject(swipeView, {}))
            swipeView.addItem(endComponent.createObject(swipeView, {}))
            break;
        }
        case "update": {
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
            break;
        }
        }


    }

    function makeObj() {
        var obj={}
        obj['name']= swipeView.itemAt(0).name
        obj['time']= Math.round(swipeView.itemAt(0).time)/1000
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
        id: childRoot
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
            ToolButton {
                id: keyboardButton
                text: Data.names[Data.settings.lang].createpage.buttons.symbkeyboard
                Material.theme: Material.Dark
                background: Rectangle {
                    radius: 5
                    color: Data.styles.actions[root.Material.theme]
                }
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                onClicked: {
                    dialog.visible=!dialog.visible
                    dialog.x=0
                    dialog.y=0
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
                CreateTaskComponent {

                }
            }

            Component {
                id: headerComponent
                Control {
                    property string name: textArea.text
                    property string time: slider.value*1000
                    property string password: passwordInput.text
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
                                font.family: electronicaNormal.name
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
                                font.pointSize: root.font.pointSize*1.8
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

    SymbolsKeyboard {
        id: dialog
        width: Math.max(parent.width,parent.height)*0.2
        height: Math.min(parent.height,parent.width)*0.5
        visible: false
        function setText(symb) {
            for(var i=0;i<swipeView.contentItem.children.length;i++) {
                //if(swipeView.contentItem.children[i].focus) root.contentItem.children[i].text+=symb;
               console.log(swipeView.contentItem.children[i].objectName)
            }
            if(swipeView.children.length!==0) setText(symb);
        }
        onCurSymbChanged: {
            setText(curSymb);
        }
    }
    FontLoader { id: electronicaNormal; source: Data.urls.fonts.Electronica.normal }
}

