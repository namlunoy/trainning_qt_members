#include "member.h"

Member::Member(QObject *parent) :
    QObject(parent)
{
    m_role = E_BA;
    m_name = "";
    m_age = 0;
}

QString Member::convertRoleToString(eRole role)
{
    switch(role)
    {
    case E_BA:
        return "BA";
    case E_TESTER:
        return "Tester";
    case E_DEVELOPER:
        return "Developer";
    case E_LEADER:
        return "Team Leader";
    default:
        return "";
    }
}

eRole Member::convertStringToRole(QString role)
{
    if(role == "BA")
        return E_BA;
    else if(role == "Tester")
        return E_TESTER;
    else if(role == "Developer")
        return E_DEVELOPER;
    else if(role == "Team Leader")
        return E_LEADER;
    else
        return E_OTHER;
}

MemberList::MemberList(QObject *parent):
    QAbstractListModel(parent)
{
    initList();
    initListModel();
}

QVariant MemberList::data(const QModelIndex &index, int role) const
{
    Q_UNUSED(role)
    return QVariant::fromValue(m_memList[index.row()]);
}

int MemberList::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return m_memList.size();
}

QHash<int, QByteArray> MemberList::roleNames() const
{
    static QHash<int, QByteArray> *pHash;
    if (!pHash) {
        pHash = new QHash<int, QByteArray>;
        (*pHash)[Qt::UserRole + 1] = "memberElement";
    }
    return *pHash;
}

void MemberList::initList()
{
    QFile file("../Ex10/data.txt");
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qDebug() << "FILE is NULL";
        return;
    }

    while (!file.atEnd()) {
        QString line = file.readLine();
        Member* member = new Member(this);

        if (line.contains("*Name")) {
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
}

void MemberList::initListModel()
{
    int begin = 0;
    int last = m_memList.size() - 1;

    beginInsertRows(QModelIndex(), begin, last);
    endInsertRows();
}

void MemberList::reWriteData()
{
    QFile file("../Ex10/data.txt");
    if (!file.open(QIODevice::WriteOnly  | QIODevice::Truncate)) {
        qDebug() << "FILE is NULL";
        return;
    }
    QString newFileData;
    QTextStream out(&file);

    for(int i = 0; i< m_memList.size(); i++) {
        Member* member = m_memList[i];

        newFileData.append("*Name: "+member->name()+"\n");
        newFileData.append("*Age: "+QString::number(member->age())+"\n");
        newFileData.append("*Role: "+member->role()+"\n");
        newFileData.append("\n");
    }

    file.resize(0);
    out << newFileData;
    file.close();
}

void MemberList::registerType(char *uri)
{
    qmlRegisterType<MemberList>(uri, 1, 0, "MyMemberList");
}

void MemberList::deleteMember(int index)
{
    beginRemoveRows(QModelIndex(), index, index);
    endRemoveRows();

    m_memList.removeAt(index);

    reWriteData();
}

void MemberList::updateMember(int index, QString name, int age, QString role)
{
    Member* member = m_memList[index];

    member->setName(name);
    member->setAge(age);
    member->setRole(role);

    beginRemoveRows(QModelIndex(), index, index);
    endRemoveRows();

    beginInsertRows(QModelIndex(), index, index);
    endInsertRows();

    reWriteData();
}

void MemberList::addMember(QString name, int age, QString role)
{
    Member* member = new Member();
    int index = m_memList.size();

    member->setName(name);
    member->setAge(age);
    member->setRole(role);

    m_memList.append(member);
    beginInsertRows(QModelIndex(), index, index);
    endInsertRows();

    reWriteData();
}
