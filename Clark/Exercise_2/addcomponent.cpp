#include "addcomponent.h"

#include <QQmlApplicationEngine>
#include <QQmlComponent>
#include <QDebug>
#include <QQmlProperty>
#include <QQuickItem>
#include <QQmlContext>
#include <QQuickWindow>

AddComponent::AddComponent(QQmlApplicationEngine &engine, QObject *parent)
    : m_engine(engine), QObject(parent)
{
}

void AddComponent::createComponent(QString model)
{
    if (m_engine.rootObjects().isEmpty()) {
        qDebug() << "Can't load main" << endl;
        return;
    }

    // Get already loaded component
    QObject *root = m_engine.rootObjects()[0];
    QObject *grid = root->findChild<QObject *>("grid");
    if (!grid) {
        qDebug() << "Can't find grid" << endl;
        return;
    }

    QObject *shape = root->findChild<QObject *>("shape");
    if (!shape) {
        qDebug() << "Can't find shape" << endl;
        return;
    }

    // Create new component
    QQmlComponent* component = new QQmlComponent(&m_engine, QUrl("qrc:/" + model));
    QObject *gridList = component->create();
    QQuickItem *item = qobject_cast<QQuickItem*>(gridList);

    // Set properties
    item->setProperty("color", QQmlProperty::read(shape, "shapeColor").toString());
    item->setProperty("insideText", QQmlProperty::read(shape, "text").toString());

    // Set where newly add component located
    item->setParentItem(qobject_cast<QQuickItem*>(grid));

    // Change ownership so component can be destroy at QML side
    QQmlEngine::setObjectOwnership(gridList, QQmlEngine::JavaScriptOwnership);
}
