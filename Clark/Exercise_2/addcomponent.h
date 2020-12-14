#ifndef ADDCOMPONENT_H
#define ADDCOMPONENT_H

#include <QObject>
#include <QQmlApplicationEngine>

class AddComponent : public QObject
{
    Q_OBJECT
public:
//    explicit AddComponent(QObject *parent = nullptr);
    explicit AddComponent(QQmlApplicationEngine &engine, QObject *parent = nullptr);
    Q_INVOKABLE void createComponent(QString model);

private:
    QQmlApplicationEngine &m_engine;

signals:

public slots:
};

#endif // ADDCOMPONENT_H
