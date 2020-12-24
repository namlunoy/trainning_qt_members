#ifndef MEMBER_H
#define MEMBER_H

#include <QObject>
#include <QDebug>
#include <QFile>
#include <QQmlEngine>
#include <QAbstractListModel>

enum eRole {
    E_TESTER = 0,
    E_BA,
    E_DEVELOPER,
    E_LEADER,
    E_OTHER
};

class Member: public QObject
{   
    Q_OBJECT

    Q_PROPERTY(QString role READ role WRITE setRole NOTIFY roleChanged)
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(int age READ age WRITE setAge NOTIFY ageChanged)

public:
    Member(QObject* parent = nullptr);

    void setRole(QString role) {m_role = convertStringToRole(role);}
    void setName(QString name) {m_name = name;}
    void setAge(int age) {m_age = age;} 
    void setId(int id) {m_id = id;}
    QString role() {return convertRoleToString(m_role);}
    QString name() {return m_name;}
    int age() {return m_age;}
    eRole getRoleEnum() const {return m_role;}
    int getId() {return m_id;}

    QString convertRoleToString(eRole role);
    eRole convertStringToRole(QString role);

signals:
    void roleChanged();
    void nameChanged();
    void ageChanged();

private:
    eRole m_role;
    QString m_name;
    int m_age;
    int m_id;
};

#endif // MEMBER_H
