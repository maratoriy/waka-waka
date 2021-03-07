#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <qmlclipboardadapter.h>
#include <backend.h>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

#ifdef Q_OS_WIN
    #define platform 1
#elif Q_OS_LINUX
    #define platform 2
#endif

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    QQmlContext *context = engine.rootContext();
    context->setContextProperty("platform", platform);

    qmlRegisterType<QmlClipboardAdapter>("ClipboardAdapter", 1, 0, "Clipboard");
    qmlRegisterType<Backend>("BackendCpp", 1, 0, "BackendCpp");

    qmlRegisterSingletonType(QUrl("qrc:/data.qml"), "Data", 1, 0, "Data");
    qmlRegisterSingletonType(QUrl("qrc:/backend.qml"), "Backend", 1, 0, "Backend");

    engine.load(url);

    return app.exec();
}
