import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQml.Models 2.12
import Data 1.0

Control {
    id: root
    property var contentObj
    function init() {
        label.text=contentObj['text']
    }

    Flickable {
                id: flick
                anchors.fill: parent
                TextArea.flickable: TextArea {
                    id: label
                    wrapMode: TextArea.Wrap
                    selectByMouse: true
                    readOnly: true
                    placeholderText: qsTr("Question")
                }
                ScrollBar.vertical: ScrollBar {}
            }
}
