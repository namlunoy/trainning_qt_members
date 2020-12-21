#ifndef MEMBERLIST_H
#define MEMBERLIST_H

#include <QObject>
#include <QVariantList>
#include <QVector>

enum ROLE {
    LEADER,
    DEVELOPER,
    BA,
    TESTER
};

struct Member {
    int role;
    QString name;
    int age;
};

enum Database {
    REPLACE,
    APPEND,
    REMOVE
};

class MemberList : public QObject
{
    Q_OBJECT
public:
    explicit MemberList(QObject *parent = nullptr);

    QVector<Member> members();
private:
    const QString database = "database.json";
    QVector<Member> m_members;


    QJsonArray readDataBase();
    void writeDatabase(const QJsonArray &array);
    void loadDatabase();
    void updateDatabase(int index, Database act);
    ROLE setRole(QString role);
    QString getRole(int role);

    void initDatabase();

signals:
    void preItemAppended();
    void postItemAppended();

    void preItemRemoved(int index);
    void postItemRemoved();

    void itemUpdated(int index);

public slots:
    void appendItem(const QString &name, const int &role, const int &age);
    void removeCompletedItems(int index);
    bool setItemAt(int index, const QString &name, const int &role, const int &age);
};

#endif // MEMBERLIST_H
