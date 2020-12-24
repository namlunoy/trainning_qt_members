#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "membermodel.h"
#include "member.h"

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

    MemberModel myListModel;
    Member *myMember = myListModel.get();

    engine.rootContext()->setContextProperty(QStringLiteral("myListModel"), &myListModel);
    engine.rootContext()->setContextProperty(QStringLiteral("myMember"), myMember);
    engine.load(url);

    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
