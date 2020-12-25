#include "MemberListModel.h"
#include "MemberDatabase.h"

#include <QDebug>

MemberListModel::MemberListModel(QObject *parent)
    : QAbstractListModel(parent),
      m_index(0)
{
    m_db = new MemberDatabase();
    m_db->loadDatabase(m_members);
    m_member = new Member();

    if (m_members.isEmpty()) {
        qDebug() << "there no members";
    } else {
        sortMemberByRole();
        copyMember(m_member, m_members.at(0));
        updateIndexAfterChanged();
    }
}

int MemberListModel::rowCount(const QModelIndex &parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    if (parent.isValid() || m_members.isEmpty()) {
        qDebug() << "can't initialize the view";
        return 0;
    }
    // FIXME: Implement me!
    return m_members.size();
}

QVariant MemberListModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || m_members.isEmpty())
        return QVariant();

    const Member *member = m_members.at(index.row());

    switch (role) {
    case ROLE:
        return QVariant(member->role());
    case NAME:
        return QVariant(member->name());
    case AGE:
        return QVariant(member->age());
    default:
        break;
    }
    return QVariant();
}

bool MemberListModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (!m_members.isEmpty())
        return false;
    Member *member = m_members.at(index.row());
    switch (role) {
    case ROLE:
        member->setRole(value.toInt());
        break;
    case NAME:
        member->setName(value.toString());
        break;
    case AGE:
        member->setAge(value.toInt());
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

Qt::ItemFlags MemberListModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;

    return Qt::ItemIsEditable; // FIXME: Implement me!
}

QHash<int, QByteArray> MemberListModel::roleNames() const
{
    QHash<int, QByteArray> attributes;
    attributes[ROLE] = "role";
    attributes[NAME] = "name";
    attributes[AGE]  = "age";
    return attributes;
}

QVector<Member *> MemberListModel::members() const
{
    return m_members;
}

void MemberListModel::setMembers(QVector<Member *> members)
{
    if (m_members == members)
        return;

    m_members = members;
    emit membersChanged(m_members);
}

void MemberListModel::copyMember(Member *dst, Member *src)
{
    dst->setName(src->name());
    dst->setRole(src->role());
    dst->setAge(src->age());
}

void MemberListModel::append()
{
    // Reset the model so the model can update when newly member is added
    beginResetModel();

    int i = m_members.size();
    beginInsertRows(QModelIndex(), i, i);

    Member *newMember = new Member();
    copyMember(newMember, m_member);
    m_members.append(newMember);

    // Sort the new added member by role
    sortMemberByRole();
    updateIndexAfterChanged();
    m_db->writeDatabase(m_members);

    endInsertRows();
    endResetModel();
}

void MemberListModel::remove()
{
    if (m_index < 0 || m_index >= m_members.size())
    {
        return;
    }

    beginResetModel();
    beginRemoveRows(QModelIndex(), m_index, m_index);
    m_members.removeAt(m_index);

    // Sort the new changed member by role
    sortMemberByRole();
    updateIndexAfterChanged();

    m_db->writeDatabase(m_members);

    endRemoveRows();
    endResetModel();
}

void MemberListModel::edit()
{
    if (m_index < 0 || m_index >= m_members.size())
    {
        return;
    }

    beginResetModel();
    Member *oldMember = m_members.at(m_index);
    if (m_member->name() == oldMember->name() && m_member->role() == oldMember->role()
            && m_member->age() == oldMember->age())
    {
        return;
    }
    Member *newMember = new Member();
    copyMember(newMember, m_member);
    m_members.replace(m_index, newMember);

    // Sort the new changed member by role
    sortMemberByRole();
    updateIndexAfterChanged();
    m_db->writeDatabase(m_members);

    dataChanged(createIndex(m_index, 0), createIndex(m_index, 0));
    endResetModel();
}

void MemberListModel::select(int index)
{
    if (index < 0 || index >= m_members.size())
    {
        return;
    }

    m_index = index;

    copyMember(m_member, m_members.at(index));
}

Member* MemberListModel::get()
{
    return m_member;
}

void MemberListModel::sortMemberByRole()
{
    std::sort(m_members.begin(), m_members.end(), [](const Member *a, const Member *b)
    {
        return a->role() < b->role();
    });
}

void MemberListModel::updateIndexAfterChanged()
{
    int newIndex = getIndexByMember(m_member);
    if (newIndex != -1)
    {
        emit indexChanged(newIndex);
    }
}

int MemberListModel::getIndexByMember(Member *member)
{
    for (int i = 0; i < m_members.size(); i++)
    {
        Member *mem = m_members.at(i);

        if (mem->age() == member->age() &&
                mem->name() == member->name() &&
                mem->role() == member->role()) {
            return i;
        }
    }

    return -1;
}
