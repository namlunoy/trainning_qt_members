#include "myshape.h"

MyShapee::MyShapee(QObject *parent) :
    QObject(parent)
{
    m_type = E_BOX;
    m_number = 0;
    m_color = "";
}

void MyShapee::declareQML()
{
    qmlRegisterType<MyShapee>("MyEnum", 1, 0, "ShapeEnum");
}

void MyShapee::addShape(MyShapee::eType type, int number, QString color)
{
    m_type = type;
    m_number = number;
    m_color = color;

    if (m_rootObj)
        QMetaObject::invokeMethod(m_rootObj, "insertToGrid",
                              Q_ARG(QVariant, m_type),
                              Q_ARG(QVariant, m_number),
                              Q_ARG(QVariant, m_color));
}
