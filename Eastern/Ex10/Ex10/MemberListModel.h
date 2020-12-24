#ifndef MEMBERLISTMODEL_H
#define MEMBERLISTMODEL_H

#include "member.h"
#include <QDir>
#include <QtAlgorithms>

class MemberListModel: public QAbstractListModel
{
    Q_OBJECT

public:
    MemberListModel(QObject* parent = nullptr);

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;
    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    QHash<int, QByteArray> roleNames() const;
    void initList();
    void reWriteData();
    void createDataFile();
    static bool memberBetterThan(const Member* mem1, const Member* mem2);
    void sortList();
    void setMemberInfor(Member* member, QString name, int age, QString role);
    int getMemberIndex(int id);

public slots:
    Q_INVOKABLE void deleteMember(int index);
    Q_INVOKABLE void updateMember(int index, QString name, int age, QString role);
    Q_INVOKABLE void addMember(QString name, int age, QString role);

private:
    QList<Member*> m_memList;
    int m_memberId;
};


#endif // MEMBERLISTMODEL_H
