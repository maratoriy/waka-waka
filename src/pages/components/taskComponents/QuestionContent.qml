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
    height: childrenRect.height
    Flickable {
                id: flick
                width: parent.width
                height: Math.min(400, contentItem.childrenRect.height)
                TextArea.flickable: TextArea {
                    id: label
                    wrapMode: TextArea.Wrap
                    height: Math.max(100, contentHeight)
                    selectByMouse: true
                    readOnly: true
                    rightInset: sb.width+3
                    placeholderText: qsTr("Question")
                }
                ScrollBar.vertical: ScrollBar { id: sb; width: 10}
            }
}
