#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "addcomponent.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    engine.load(url);

    // Pass already loaded engine to context
    AddComponent addComponent(engine);
    QQmlContext *context = engine.rootContext();
    context->setContextProperty("addComponent", &addComponent);

    return app.exec();
}