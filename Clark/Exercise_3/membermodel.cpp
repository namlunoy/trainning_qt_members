#include "membermodel.h"

MemberModel::MemberModel(QObject *parent)
    : QAbstractListModel(parent)
{
    m_members = new MemberList();
}

int MemberModel::rowCount(const QModelIndex &parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    if (parent.isValid() || !m_members)
        return 0;

    // FIXME: Implement me!
    return m_members->members().size();
}

QVariant MemberModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || !m_members)
        return QVariant();

    const Member member = m_members->members().at(index.row());

    switch (role) {
    case ROLE:
        return QVariant(member.role);
    case NAME:
        return QVariant(member.name);
    case AGE:
        return QVariant(member.age);
    default:
        break;
    }
    return QVariant();
}

bool MemberModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (!m_members)
        return false;
    Member member = m_members->members().at(index.row());
    switch (role) {
    case ROLE:
        member.role = value.toInt();
        break;
    case NAME:
        member.name = value.toString();
        break;
    case AGE:
        member.age = value.toInt();
        break;
    default:
        break;
    }

    if (data(index, role) != value) {
        // FIXME: Implement me!
        emit dataChanged(index, index, QVector<int>() << role);
        return true;
    }
    return false;
}

Qt::ItemFlags MemberModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;

    return Qt::ItemIsEditable; // FIXME: Implement me!
}

QHash<int, QByteArray> MemberModel::roleNames() const
{
    QHash<int, QByteArray> attributes;
    attributes[ROLE] = "role";
    attributes[NAME] = "name";
    attributes[AGE]  = "age";
    return attributes;
}

MemberList *MemberModel::members() const
{
    return m_members;
}

void MemberModel::setMembers(MemberList *member)
{
    beginResetModel();

    if (m_members)
        m_members->disconnect(this);

    m_members = member;

    if (m_members)
    {
        connect(m_members, &MemberList::preItemAppended, this, [=]() {
            const int index = m_members->members().size();
            beginInsertRows(QModelIndex(), index, index);
        });
        connect(m_members, &MemberList::postItemAppended, this, [=]() {
            endInsertRows();
        });
        connect(m_members, &MemberList::preItemRemoved, this, [=](int index) {
            beginRemoveRows(QModelIndex(), index, index);
        });
        connect(m_members, &MemberList::postItemRemoved, this, [=]() {
            endRemoveRows();
        });
        connect(m_members, &MemberList::itemUpdated, this, [=](int index) {
            dataChanged(createIndex(index, 0), createIndex(index, 0));
        });
    }
}
