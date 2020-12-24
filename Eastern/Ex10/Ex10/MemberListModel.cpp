#include "MemberListModel.h"

MemberListModel::MemberListModel(QObject *parent):
    QAbstractListModel(parent)
{
    m_memberId = 0;
    initList();
}

QVariant MemberListModel::data(const QModelIndex &index, int role) const
{
    Q_UNUSED(role)
    return QVariant::fromValue(m_memList[index.row()]);
}

int MemberListModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return m_memList.size();
}

QHash<int, QByteArray> MemberListModel::roleNames() const
{
    static QHash<int, QByteArray> *pHash;
    if (!pHash) {
        pHash = new QHash<int, QByteArray>;
        (*pHash)[Qt::UserRole + 1] = "memberElement";
    }
    return *pHash;
}

void MemberListModel::initList()
{
    QFile file("data.txt");
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qDebug() << "FILE is NULL";
        createDataFile();
        return;
    }

    while (!file.atEnd()) {
        QString line = file.readLine();
        Member* member = new Member(this);
        int id = 0;

        if (line.contains("*Id")) {
            line = line.remove(0,5);
            line.replace("\n", "");
            id = line.toInt();
            if (id > m_memberId)
                m_memberId = id+1;
            member->setId(id);

            line = file.readLine();
            if (!line.contains("*Name"))
                continue;
            line = line.remove(0,7);
            line.replace("\n", "");
            member->setName(line);

            line = file.readLine();
            if (!line.contains("*Age"))
                continue;
            line = line.remove(0,6);
            member->setAge(line.toInt());

            line = file.readLine();
            if (!line.contains("*Role"))
                continue;
            line = line.remove(0,7);
            line.replace("\n", "");
            member->setRole(line);

            m_memList.append(member);
        }
    }

    file.close();
    sortList();
}

void MemberListModel::reWriteData()
{
    QFile file("data.txt");
    if (!file.open(QIODevice::WriteOnly  | QIODevice::Truncate)) {
        qDebug() << "FILE is NULL";
        createDataFile();
        return;
    }
    QString newFileData;
    QTextStream out(&file);

    sortList();

    for(int i = 0; i< m_memList.size(); i++) {
        Member* member = m_memList[i];

        newFileData.append("*Id: "+QString::number(member->getId())+"\n");
        newFileData.append("*Name: "+member->name()+"\n");
        newFileData.append("*Age: "+QString::number(member->age())+"\n");
        newFileData.append("*Role: "+member->role()+"\n");
        newFileData.append("\n");
    }

    file.resize(0);
    out << newFileData;
    file.close();
}

void MemberListModel::createDataFile()
{
    QFile file("data.txt");
    file.open(QIODevice::WriteOnly);
}

bool MemberListModel::memberBetterThan(const Member* mem1, const Member* mem2)
{
    return mem1->getRoleEnum() > mem2->getRoleEnum();
}

void MemberListModel::sortList()
{
    qSort(m_memList.begin(), m_memList.end(), memberBetterThan);
}

void MemberListModel::setMemberInfor(Member* member, QString name, int age, QString role)
{
    member->setName(name);
    member->setAge(age);
    member->setRole(role);
    member->setId(m_memberId);
    m_memberId++;
}

int MemberListModel::getMemberIndex(int id)
{
    for(int i = 0; i < m_memList.size(); i++) {
        if(m_memList[i]->getId() == id)
            return i;
    }
    return -1;
}

void MemberListModel::deleteMember(int index)
{
    qDebug() << index;

    beginRemoveRows(QModelIndex(), index, index);
    m_memList.removeAt(index);
    endRemoveRows();

    reWriteData();
}

void MemberListModel::updateMember(int index, QString name, int age, QString role)
{
    Member* member = m_memList[index];

    beginRemoveRows(QModelIndex(), index, index);
    endRemoveRows();

    setMemberInfor(member, name, age, role);
    reWriteData();

    index = getMemberIndex(member->getId());
    beginInsertRows(QModelIndex(), index, index);
    endInsertRows();
}

void MemberListModel::addMember(QString name, int age, QString role)
{
    Member* member = new Member();
    int index = 0;

    setMemberInfor(member, name, age, role);
    m_memList.append(member);
    reWriteData();

    index = getMemberIndex(member->getId());
    beginInsertRows(QModelIndex(), index, index);
    endInsertRows();
}
