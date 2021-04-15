import QtQuick 2.12
import QtQuick.Controls 2.12
import Data 1.0
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.12
import "controls"

Control {
    function init(contentObj) {
        textArea.text=contentObj['questionContent']['text']

        cd1.checked=contentObj['showAnswer']===true

        comboBox.currentIndex=Data.typeList.indexOf(contentObj['type'])

        var conObj = Object.assign({}, contentObj['question'],
                   {
                       'showAnswer': contentObj['showAnswer']
                   })
        loader.item.init(conObj)
        basicScoreArea.text=contentObj['question']['basicScore']
    }
    function getObj() {
        var obj={
            'questionContent': {
                'text': textArea.text
            },
            'type': Data.typeList[comboBox.currentIndex],
            'question': Object.assign({},
                loader.item.getObj(),
                { 'basicScore': (Data.typeList[comboBox.currentIndex]==="Theory") ? 0 : parseInt(basicScoreArea.text)}
            ),
            'showAnswer': cd1.checked
        }
        return obj
    }
    function setText(str) {
        loader.item.obj.text+=str;
    }

    function reset() {
        textArea.clear()
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
        Column {
            width: parent.width
            height: childrenRect.height
        Grid {
            width: parent.width
            height: childrenRect.height
            columns: 1
            CheckDelegate {
                id: cd1
                visible: comboBox.curType!=="Theory"
                text: "Показывать ответ в результатах";
                checked: false;
            }
        }
        Row {
            id: setRow
            width: parent.width
            height: 50
            spacing: width*0.1
            leftPadding: width/50
            ComboBox {
                id: comboBox
                width: parent.width*0.4
                property string curType: Data.typeList[currentIndex]
                model: Data.names[Data.settings.lang].createpage.taskComponent.typeList
                delegate: Control {
                    width: comboBox.width
                    height: childrenRect.height
                    background: Rectangle {
                        color: 'white'
                    }
                    ItemDelegate {
                        width: parent.width
                        text: modelData
                        onClicked: {
                            comboBox.popup.close()
                            comboBox.currentIndex=comboBox.model.indexOf(modelData)
                        }
                    }
                }
                onCurrentIndexChanged:
                    loader.source="qrc:/pages/components/tasks/"+Data.typeList[currentIndex]+"/create.qml"
            }
            MyTextField {
                id: basicScoreArea
                width: parent.width*0.4
                height: 50
                visible: comboBox.curType!=="Theory"
                validator: IntValidator {

                }
                placeholderText: Data.names[Data.settings.lang].createpage.taskComponent.basicscore
                horizontalAlignment: TextArea.AlignLeft
                font.pixelSize: height*0.4
            }
        }
        Flickable {
            id: flick
            width: parent.width-10
            visible: comboBox.curType==="Theory" ? false : true
            height: Math.min(Math.max(100, textArea.contentHeight+25), 400)
            TextArea.flickable: TextArea {
                id: textArea
                wrapMode: TextArea.Wrap
                selectByMouse: true
                placeholderText: Data.names[Data.settings.lang].createpage.taskComponent.question
            }
            ScrollBar.vertical: ScrollBar {}
        }

        Loader {
            id: loader
            width: parent.width-10
            height : childrenRect.height
        }
        }

    }


    property alias area: textArea.text

}
