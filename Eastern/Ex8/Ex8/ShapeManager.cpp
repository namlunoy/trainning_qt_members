#include "ShapeManager.h"

ShapeManager::ShapeManager(QObject *parent) :
    QObject(parent)
{
    m_type = E_BOX;
    m_number = 0;
    m_color = "";
}

void ShapeManager::declareQML()
{
    qmlRegisterType<ShapeManager>("MyEnum", 1, 0, "ShapeEnum");
}

void ShapeManager::addShape(ShapeManager::eType type, int number, QString color)
{
    QObject *sidebarObj = m_rootObj->findChild<QObject *>("sidebarView");
    QQmlEngine *engine = new QQmlEngine;
    QQmlComponent component(engine, QUrl("qrc:/MyShape.qml"));

    QObject *myObject = component.create();
    QQuickItem *item = qobject_cast<QQuickItem*>(myObject);
    item->setProperty("shapeType", type);
    item->setProperty("shapeNumber", number);
    item->setProperty("shapeColor", color);
    item->setParentItem(qobject_cast<QQuickItem*>(sidebarObj));

    QQmlEngine::setObjectOwnership(item, QQmlEngine::JavaScriptOwnership);
}
