pragma Singleton
import QtQuick 2.14
import ClipboardAdapter 1.0
import BackendCpp 1.0

Item {
    id: root
    BackendCpp {
        id: backendCpp
    }
    function prepareKeywords(keywords) {

        return backendCpp.prepareKeywords(keywords)
    }

    function checkTextAnswer(panswer, keywords) {
        return backendCpp.compareStrings(panswer, keywords)
    }

    function fromWideString(str) {
        return backendCpp.base64ToJSON(str)
    }

    function toWideString(str) {
        return backendCpp.jsonToBase64(str)
    }
    property var strings: {
          'createStringFromTemplate': (...args)=> { return args.reduce((prev, cur)=> {return prev.replace('%s', cur)})}

    }


    //буфер обмена
    property alias clipboard: _clipboard
    Clipboard {
        id: _clipboard
    }
}
