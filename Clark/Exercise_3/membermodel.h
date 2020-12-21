#ifndef MEMBERMODEL_H
#define MEMBERMODEL_H

#include <QAbstractListModel>

#include "memberlist.h"

class MemberModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(MemberList *members READ members WRITE setMembers)

public:
    explicit MemberModel(QObject *parent = nullptr);

    enum {
        ROLE = Qt::UserRole,
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

    MemberList *members() const;
    void setMembers(MemberList *members);

private:
    MemberList *m_members;
};

#endif // MEMBERMODEL_H
