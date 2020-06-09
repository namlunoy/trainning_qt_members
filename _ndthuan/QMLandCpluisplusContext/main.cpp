#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "QQmlContext"
#include "clocktimer.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    ClockTimer timer;
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("TimerTest", &timer);
    const QUrl url(QStringLiteral("qrc:/main.qml"));

    engine.load(url);

    return app.exec();
}
