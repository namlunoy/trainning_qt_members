#ifndef MEMBER_H
#define MEMBER_H

#include <QObject>

class Member : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(int role READ role WRITE setRole NOTIFY roleChanged)
    Q_PROPERTY(int age READ age WRITE setAge NOTIFY ageChanged)

public:
    explicit Member(QObject *parent = nullptr);
    Member(QString name, int role, int age);

    QString name() const;
    int role() const;
    int age() const;

signals:
    void nameChanged();
    void roleChanged();
    void ageChanged();

public slots:
    void setName(const QString &name);
    void setRole(int role);
    void setAge(int age);

private:
    QString m_name;
    int m_role;
    int m_age;
};

#endif // MEMBER_H
