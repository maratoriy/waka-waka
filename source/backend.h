#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>

class Backend : public QObject
{
    Q_OBJECT
public:
    explicit Backend(QObject *parent = nullptr);

    Q_INVOKABLE static QString jsonToBase64(QString);
    Q_INVOKABLE static QString base64ToJSON(QString);
    Q_INVOKABLE static QString prepareKeywords(QString);
    Q_INVOKABLE static float   compareStrings(QString, QString);
    Q_INVOKABLE static QString imgToBase64(QString);
};

#endif // BACKEND_H
