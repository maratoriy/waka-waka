import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import Data 1.0

TextField {
    selectByMouse: true
    padding: 20
    topInset: 5
    bottomInset: 5
    verticalAlignment: TextField.AlignVCenter
    background: Rectangle {
        radius: 5
        border.width: 1
        border.color: Data.styles.actions[Data.settings.theme]
    }
}
