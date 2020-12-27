import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12
import Qt.labs.qmlmodels 1.0
import "components"
import Data 1.0
import Backend 1.0

Page {
    id: root
    property var testObj
    function init() {
        swipeView.addItem(headerComponent.createObject(swipeView, {}))
        for(let key in testObj['taskList']) {
            swipeView.addItem(resultsTaskComponent.createObject(swipeView, {}))
            swipeView.itemAt(swipeView.count-1).init(testObj['taskList'][key])
        }
    }

    Control {
        width: parent.width*0.90
        height: parent.height*0.90
        anchors.centerIn: parent
        Control {
            clip: true
            width: parent.width
            height: parent.height*0.9
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
        }
    }
    Component {
        id: resultsTaskComponent
        ResultsTaskComponent {

        }
    }

    Component {
        id: headerComponent
        Control {
            Label {
                anchors.top: parent.top
                text: Backend.strings.createStringFromTemplate(Data.names[Data.settings.lang].resultspage.headercomponent.infotext,
                                                               testObj['name'],
                                                               testObj['pupil'],
                                                               new Date(testObj['ptime']*1000).toLocaleTimeString(Qt.locale(), "mm:" + "ss"),
                                                               testObj['score'],
                                                               testObj['basicScore'],
                                                               Math.round(100*testObj['score']/testObj['basicScore']))
//                text: `Name: ${testObj['name']}\n`+
//                      `Pupil: ${testObj['pupil']}\n`+
//                      `Time: ${new Date(testObj['ptime']*1000).toLocaleTimeString(Qt.locale(), "mm:" + "ss")}
//                      Score: ${testObj['score']}
//                      BasicScore: ${testObj['basicScore']}
//                      Percentage: ${Math.round(100*testObj['score']/testObj['basicScore'])}`
            }
        }
    }
}
