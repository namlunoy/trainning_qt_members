#include "member.h"
#include <QDebug>

Member::Member(QObject *parent) : QObject(parent),
    m_name("Default name"),
    m_role(0),
    m_age(99)
{

}

Member::Member(QString name, int role, int age)
{
    m_name = name;
    m_role = role;
    m_age = age;
}

int Member::age() const
{
    return m_age;
}

void Member::setAge(int age)
{
    if (age == m_age)
        return;
    m_age = age;
    emit ageChanged();
}

int Member::role() const
{
    return m_role;
}

void Member::setRole(int role)
{
    if (role == m_role)
        return;
    m_role = role;
    emit roleChanged();
}

QString Member::name() const
{
    return m_name;
}

void Member::setName(const QString &name)
{
    if (name == m_name)
        return;

    m_name = name;
    emit nameChanged();
}
