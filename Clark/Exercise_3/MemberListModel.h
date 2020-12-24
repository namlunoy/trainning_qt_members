#ifndef MEMBERMODEL_H
#define MEMBERMODEL_H

#include <QAbstractListModel>
#include <QVector>

#include "Member.h"
#include "MemberDatabase.h"

class MemberListModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(QVector<Member*> members READ members WRITE setMembers NOTIFY membersChanged)

public:
    explicit MemberListModel(QObject *parent = nullptr);

    enum {
        ROLE = Qt::UserRole + 1,
        NAME,
        AGE
    };

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    // Editable:
    bool setData(const QModelIndex &index, const QVariant &value,
                 int role = Qt::EditRole) override;

    Qt::ItemFlags flags(const QModelIndex& index) const override;

    virtual QHash<int, QByteArray> roleNames() const override;

    QVector<Member*> members() const;

    Member *get();

public slots:
    void setMembers(QVector<Member*> members);

signals:
    void membersChanged(QVector<Member*> members);

private:
    QVector<Member*> m_members;
    Member *m_member;
    MemberDatabase *m_db;
    int m_index;

    void copyMember(Member *dst, Member* src);
    void sortMemberByRole();

public:
    Q_INVOKABLE void append();
    Q_INVOKABLE void remove();
    Q_INVOKABLE void edit();
    Q_INVOKABLE void select(int index);
};



#endif // MEMBERMODEL_H
