#ifndef MEMBER_H
#define MEMBER_H

#include <QObject>
#include <QDebug>
#include <QFile>
#include <QDir>
#include <QQmlEngine>

enum eRole {
    E_BA = 0,
    E_TESTER,
    E_DEVELOPER,
    E_LEADER,
    E_OTHER
};

class Member
{   
public:
    Member();
    Member(eRole role, QString name, int age);

    void setRole(eRole role) {m_role = role;}
    void setName(QString name) {m_name = name;}
    void setAge(int age) {m_age = age;}
    eRole getRole() {return m_role;}
    QString getName() {return m_name;}
    int getAge() {return m_age;}


private:
    eRole m_role;
    QString m_name;
    int m_age;
};

class MemberList: public QObject
{
    Q_OBJECT

public:
    MemberList(QObject* parent = nullptr);

    void setRootObj(QObject* obj) {m_root = obj;}
    void initList();
    eRole convertStringToRole(QString role);
    QString convertRoleToColor(eRole role);
    QString convertRoleToString(eRole role);
    void initListModel();
    void declareRole();
    void reWriteData();

public slots:
    void deleteMember(int index);
    void updateMember(int index, QString name, int age, int role);
    void addMember(QString name, int age, int role);

private:
    QObject* m_root;
    std::vector<Member> m_memList;
};



#endif // MEMBER_H
