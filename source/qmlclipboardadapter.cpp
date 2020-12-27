#include "qmlclipboardadapter.h"
#include <QGuiApplication>
#include <QClipboard>
QmlClipboardAdapter::QmlClipboardAdapter(QObject *parent) : QObject(parent) {
}
void QmlClipboardAdapter::setText(QString text){
    QClipboard *clipboard = QGuiApplication::clipboard();
    clipboard->setText(text, QClipboard::Clipboard);
}
