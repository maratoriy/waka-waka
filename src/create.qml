import QtQuick 2.12
import QtQuick.Controls 2.12
import Data 1.0
import "pages"

Page {
    id: root
    title: Data.names[Data.settings.lang].createpage.title
    CreatePage {
       anchors.fill: parent
       Component.onCompleted: init()
    }
}
