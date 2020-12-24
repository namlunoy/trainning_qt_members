#ifndef MEMBERDATABASE_H
#define MEMBERDATABASE_H

#include <QVector>

#include "Member.h"

enum ROLE {
    LEADER,
    DEVELOPER,
    BA,
    TESTER
};

enum Database {
    REPLACE,
    APPEND,
    REMOVE
};

class MemberDatabase
{
public:

    void loadDatabase(QVector<Member*> &members);
    void updateDatabase(QVector<Member*> &members, int index, Database act);

    MemberDatabase();
    QJsonArray readDataBase();
    void writeDatabase(const QJsonArray &array);
    ROLE setRole(QString role);
    QString getRole(int role);

    void initDatabase();

private:
    const QString database = "database.json";

};

#endif // MEMBERDATABASE_H
