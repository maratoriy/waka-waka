import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import "pages"
import Data 1.0
import Backend 1.0

Page {
    id: root
    title: Data.names[Data.settings.lang].openpage.title
    property var contentObj
    Loader {
        id: loader
        anchors.fill: parent
        clip: true
        sourceComponent: headerComponent
    }
    Component {
        id: headerComponent
        Control {
        Component {
            id: errorComponent
            Label {
                id: errorLabel
            }
        }
        Component {
            id: doCreateComponent
            Column {
                function accept() {
                    if(updateRadioButton.checked && passwordArea.text===contentObj['password']) {
                        loader.source="qrc:/pages/CreatePage.qml"
                        loader.item.init("update", contentObj)
                    } else if(testRadioButton.checked){
                        loader.source="qrc:/pages/TestPage.qml"
                        loader.item.contentObj=contentObj
                        loader.item.init()
                    } else if(resultRadioButton.checked){
                        loader.source="qrc:/pages/ResultsPage.qml"
                        loader.item.contentObj=contentObj
                        loader.item.init()
                    } else {
                        passwordArea.clear(); passwordArea.placeholderText=Data.names[Data.settings.lang].openpage.headercomponent.passworderror; passwordArea.placeholderTextColor="red"
                    }
                }
                Label {
                    id: infoLabel
                    width: parent.width
                    font.pointSize: root.font.pointSize*1.3
                    color: "black"
                    text: Backend.strings.createStringFromTemplate(Data.names[Data.settings.lang].openpage.headercomponent.infotext,
                                                 contentObj['name'],
                                                 new Date(contentObj['time']*1000).toLocaleTimeString(Qt.locale(), "mm:" + "ss"),
                                                 contentObj['count'],
                                                 contentObj['type']
                                                 )
                }
                ButtonGroup {
                    id: radioGroup
                }
                Column {
                    clip: true
                    width: parent.width
                    height: parent.height-infoLabel.height
                    RadioButton {
                        id: resultRadioButton
                        checked: contentObj['type']==='result'
                        text: Data.names[Data.settings.lang].openpage.headercomponent.buttons.result
                        enabled: contentObj['type']==='result'
                        Material.theme: Material.Light
                        ButtonGroup.group: radioGroup
                    }
                    RadioButton {
                        id: testRadioButton
                        checked: true && contentObj['type']==='blank'
                        text: Data.names[Data.settings.lang].openpage.headercomponent.buttons.test
                        enabled: contentObj['type']==='blank'
                        Material.theme: Material.Light
                        ButtonGroup.group: radioGroup
                    }
                    RadioButton {
                        id: updateRadioButton
                        text: Data.names[Data.settings.lang].openpage.headercomponent.buttons.update
                        enabled: contentObj['type']==='blank'
                        Material.theme: Material.Light
                        ButtonGroup.group: radioGroup
                    }
                    Column {
                        width: parent.width
                        visible: updateRadioButton.checked
                        leftPadding: width*0.025
                        TextArea {
                            id: passwordArea
                            width: parent.width
                            placeholderText: Data.names[Data.settings.lang].openpage.headercomponent.passwordplace
                            color: "black"
                            inputMethodHints: Qt.ImhHiddenText
                            Material.theme: Material.Light
                        }
                    }
                }
            }
        }

        Component {
            id: enterKeyComponent
            Control {
                function accept() {
                    contentObj=JSON.parse(Backend.fromWideString(textArea.text))
                    stackView.push(doCreateComponent.createObject(stackView, {}));
                }
                clip: true
                Flickable {
                    id: flick
                    anchors.fill: parent
                    TextArea.flickable: TextArea {
                        id: textArea
                        color: 'black'
                        wrapMode: TextArea.Wrap
                        selectByMouse: true
                        placeholderText: Data.names[Data.settings.lang].openpage.enterkeycomponent.codeplace
                    }
                    ScrollBar.vertical: ScrollBar {}
                }
            }
        }

        Control {
            width: parent.width*0.90
            height: parent.height*0.95
            anchors.centerIn: parent
            Control {
                width: parent.width
                height: parent.height*0.85
                anchors.top: parent.top
                background: Rectangle {
                    color: "white"
                    radius: 10
                }
                StackView {
                    id: stackView
                    clip: true
                    initialItem: enterKeyComponent
                    width: parent.width*0.95
                    height: parent.height*0.95
                    anchors.centerIn: parent
                }
            }
            Control {
                width: parent.width
                height: parent.height*0.1
                anchors.bottom: parent.bottom
                background: Rectangle {
                    color: Data.styles.actions[root.Material.theme]
                    radius: 5
                }
                ToolButton {
                    anchors.fill: parent
                    text: Data.names[Data.settings.lang].openpage.enterkeycomponent.buttons.enter
                    Material.theme: Material.Dark
                    onClicked: {
                        stackView.currentItem.accept()
                    }
                }
            }
        }
    }
    }
}
