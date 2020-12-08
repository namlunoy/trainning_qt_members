#include "test.h"

MyClass::MyClass(QObject* parent):
    QObject(parent)
{
    m_val = 25;
}

void MyClass::increase()
{
    m_val++;
    qDebug() << "val=" << m_val;
    Q_EMIT valChanged();
}

void MyClass::decrease()
{
    m_val--;
    qDebug() << "val=" << m_val;
    Q_EMIT valChanged();
}

void MyClass::reset()
{
    m_val = 25;
    qDebug() << "val=" << m_val;
    Q_EMIT valChanged();
}

void MyClass::set()
{
    setVal(50);
    qDebug() << "val=" << m_val;
    Q_EMIT valChanged();
}
