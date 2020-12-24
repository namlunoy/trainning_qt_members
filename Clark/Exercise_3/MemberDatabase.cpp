#include "MemberDatabase.h"

#include <QFile>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QString>
#include <QDebug>
#include <QFileInfo>

MemberDatabase::MemberDatabase()
{

}

QJsonArray MemberDatabase::readDataBase()
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

void MemberDatabase::writeDatabase(const QJsonArray &array)
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

void MemberDatabase::loadDatabase(QVector<Member*> &members)
{
    QJsonArray array = readDataBase();

    // Load data to vector m_members
    foreach (const QJsonValue &v, array) {
        Member *member = new Member(
                    v.toObject().value("name").toString(),
                    setRole(v.toObject().value("role").toString()),
                    v.toObject().value("age").toInt());
        members.append(member);
    }
}


void MemberDatabase::updateDatabase(QVector<Member*> &members, int index, Database act)
{
    QJsonArray array = readDataBase();

    auto data = QJsonObject(
    {
        qMakePair(QString("name"), QJsonValue(members.at(index)->name())),
        qMakePair(QString("role"), QJsonValue(getRole(members.at(index)->role()))),
        qMakePair(QString("age"), QJsonValue(members.at(index)->age()))
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

ROLE MemberDatabase::setRole(QString role)
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

QString MemberDatabase::getRole(int role)
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

void MemberDatabase::initDatabase()
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
