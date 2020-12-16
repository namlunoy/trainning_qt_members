#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQmlComponent>
#include <unistd.h>

#include "member.h"


int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    MemberList memberList;
    memberList.declareRole();
    engine.rootContext()->setContextProperty("MyMemberList", &memberList);

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
//    engine.load(url);

    QQmlComponent component(&engine, url);

    while (!component.isReady())
    {
        qDebug() << "component is not ready";
        usleep(300000);
    }

    QObject* obj = component.create();
    QObject* grid = obj->findChild<QObject*>("memberObj");
    if(grid) {
        memberList.setRootObj(grid);
        memberList.initListModel();
    }
    else {
        qDebug() << "Member object is NULL";
    }

    return app.exec();
}
