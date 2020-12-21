#ifndef MEMBER_H
#define MEMBER_H

#include <QObject>
#include <QDebug>
#include <QFile>
#include <QQmlEngine>
#include <QAbstractListModel>

enum eRole {
    E_BA = 0,
    E_TESTER,
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
    QString role() {return convertRoleToString(m_role);}
    QString name() {return m_name;}
    int age() {return m_age;}

    QString convertRoleToString(eRole role);
    eRole convertStringToRole(QString role);

Q_SIGNALS:
    void roleChanged();
    void nameChanged();
    void ageChanged();

private:
    eRole m_role;
    QString m_name;
    int m_age;
};

class MemberList: public QAbstractListModel
{
    Q_OBJECT

public:
    MemberList(QObject* parent = nullptr);

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;
    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    QHash<int, QByteArray> roleNames() const;
    void initList();

    void initListModel();
    void reWriteData();
    static void registerType(char* uri);

public slots:
    Q_INVOKABLE void deleteMember(int index);
    Q_INVOKABLE void updateMember(int index, QString name, int age, QString role);
    Q_INVOKABLE void addMember(QString name, int age, QString role);

private:
    QList<Member*> m_memList;
};



#endif // MEMBER_H
