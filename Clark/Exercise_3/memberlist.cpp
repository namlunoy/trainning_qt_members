#include "memberlist.h"

#include <QFile>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QString>
#include <QDebug>

#include <QDirIterator>

MemberList::MemberList(QObject *parent) : QObject(parent)
{
    loadDatabase();
}

QJsonArray
MemberList::readDataBase()
{
    if (!QFileInfo::exists(database)) {
        initDatabase();
    }

    QFile file(database);
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qDebug() << "Error: opening database failed" << endl;
        return QJsonArray();
    }
    QByteArray jsonData = file.readAll();
    file.close();

    QJsonDocument document = QJsonDocument::fromJson(jsonData);
    QJsonObject object = document.object();
    QJsonValue value = object.value("members");

    return value.toArray();
}

void
MemberList::initDatabase()
{
    QJsonArray array;
    for (int i = 0; i < 4; i++) {
        auto data = QJsonObject(
        {
            qMakePair(QString("name"), QJsonValue("Name" + QString::number(i))),
            qMakePair(QString("role"), QJsonValue(getRole(i))),
            qMakePair(QString("age"), QJsonValue(20 + i))
        });

        array.push_back(data);
    }

    writeDatabase(array);
}

void
MemberList::writeDatabase(const QJsonArray &array)
{
    QFile file(database);
    if (!file.open(QIODevice::ReadWrite | QIODevice::Text | QIODevice::Truncate)) {
        qDebug() << "Error: opening database to write failed" << endl;
        return;
    }

    QJsonDocument document;
    QJsonObject object = QJsonObject( { qMakePair(QString("members"), QJsonValue(array)) } );
    document.setObject(object);

    file.write(document.toJson());

    file.close();
}

void
MemberList::loadDatabase()
{
    QJsonArray array = readDataBase();

    // Load data to vector m_members
    foreach (const QJsonValue &v, array) {
        m_members.append({
                        setRole(v.toObject().value("role").toString()),
                        v.toObject().value("name").toString(),
                        v.toObject().value("age").toInt()
                         });
    }
}

void
MemberList::updateDatabase(int index, Database act)
{
    QJsonArray array = readDataBase();

    Member member = m_members.at(index);

    auto data = QJsonObject(
    {
        qMakePair(QString("name"), QJsonValue(member.name)),
        qMakePair(QString("role"), QJsonValue(getRole(member.role))),
        qMakePair(QString("age"), QJsonValue(member.age))
    });

    switch(act) {
    case REPLACE:
        array.replace(index, QJsonValue(data));
        break;
    case APPEND:
        array.push_back(QJsonValue(data));
        break;
    case REMOVE:
        array.removeAt(index);
        break;
    default:
        return;
    }

    writeDatabase(array);
}

ROLE
MemberList::setRole(QString role)
{
    QStringList options;
    options << "Team Leader" << "Developer" << "BA" << "Tester";

    switch (options.indexOf(role)) {
    case 0:
        return LEADER;
    case 1:
        return DEVELOPER;
    case 2:
        return BA;
    case 3:
        return TESTER;
    default:
        return TESTER;
    }
}

QString
MemberList::getRole(int role)
{
    switch (role) {
    case 0:
        return "Team Leader";
    case 1:
        return "Developer";
    case 2:
        return "BA";
    case 3:
        return "Tester";
    default:
        return "Tester";
    }
}

QVector<Member>
MemberList::members() {
    return m_members;
}

bool
MemberList::setItemAt(int index, const QString &name, const int &role, const int &age)
{
    if (index < 0 || index >= m_members.size())
    {
        return false;
    }

    Member member = { role, name, age };

    const Member &oldMember = m_members.at(index);
    if (member.name == oldMember.name && member.role == oldMember.role
            && member.age == oldMember.age)
    {
        return false;
    }
    m_members.replace(index, member);

    emit itemUpdated(index);

    updateDatabase(index, REPLACE);

    return true;
}

void
MemberList::appendItem(const QString &name, const int &role, const int &age)
{
    emit preItemAppended();

    Member member;
    member.age = age;
    member.name = name;
    member.role = role;
    m_members.append(member);

    emit postItemAppended();

    updateDatabase(m_members.size() - 1, APPEND);
}

void
MemberList::removeCompletedItems(int index)
{
    if (index < 0 || index >= m_members.size())
    {
        return;
    }

    emit preItemRemoved(index);

    updateDatabase(index, REMOVE);
    m_members.removeAt(index);

    emit postItemRemoved();
}
