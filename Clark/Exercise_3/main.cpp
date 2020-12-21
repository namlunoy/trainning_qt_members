#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "memberlist.h"
#include "membermodel.h"

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

    qmlRegisterType<MemberModel>("MemberModel", 1, 0, "MemberModel");
    qmlRegisterUncreatableType<MemberList>("MemberList", 1, 0, "MemberList",
        QStringLiteral("MemberList should not be created in QML"));

    MemberList memberList;

    engine.rootContext()->setContextProperty(QStringLiteral("memberList"), &memberList);
    engine.load(url);

    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
