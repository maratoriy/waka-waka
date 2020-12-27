#include "backend.h"
#include "QDebug"
#include "QImage"
#include "QBuffer"

Backend::Backend(QObject *parent) : QObject(parent)
{

}
QString Backend::jsonToBase64(QString str) {
    return QString::fromUtf8(str.toUtf8().toBase64());
}
QString Backend::base64ToJSON(QString str) {
    return QString::fromUtf8(QByteArray::fromBase64(str.toUtf8()));
}
QRegExp filter("(ёшь|ёте|ять|ями|яли|яла|ыми|умя|ули|ула|оть|ому|оли|ола|ого|ишь|ите|ими|ешь|еть|ете|емя|еми|ели|ела|его|ать|ами|али|ала|ёх|ёт|ях|ят|ял|ют|ыя|ыю|ых|ым|ый|ыи|ые|шь|ую|ух|ут|ум|ул|ть|см|оё|ою|ом|ол|ой|ое|ов|мя|ми|ия|ию|их|ит|им|ий|ии|ие|её|ею|ех|ет|ем|ел|ей|ая|ах|ас|ам|ал|ю|ы|у|о|м|и|е|а)$");
QRegExp filterP("[.,;:-«»!\"'@#^%&*!()_+=`~><{}]");
float Backend::compareStrings(QString panswer, QString keywords) {
    QString m_panswer= panswer.toLower().remove(QRegExp(filterP));
    QStringList pansList=m_panswer.split(" ");
    QStringList ansList=keywords.split(" ");
    pansList.replaceInStrings(QRegExp("ся$"), "").replaceInStrings(filter, "");
    float totalCount=ansList.size(), count=0;
    for(auto ansListIter:ansList) {
        if(pansList.contains(ansListIter)) count++;
    }
    qDebug()<<ansList<<pansList;
    return count/totalCount;
}
QString Backend::prepareKeywords(QString wideString) {
    QStringList list =wideString.toLower().remove(QRegExp(filterP)).split(" ").filter(QRegExp(".{4}"));
    list.replaceInStrings(QRegExp("ся$"), "").replaceInStrings(filter, "");
    return list.join(" ");
}
QString Backend::imgToBase64(QString src) {
    QImage image;;
    image.load(src);
    QByteArray byteArray;
    QBuffer buffer(&byteArray);
    image.save(&buffer, "PNG");
    QString imageBase64 = QString::fromLatin1(byteArray.toBase64().data());
    return imageBase64;
}
