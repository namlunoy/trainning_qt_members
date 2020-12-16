#include "member.h"

Member::Member()
{
    m_role = E_BA;
    m_name = "";
    m_age = 0;
}

Member::Member(eRole role, QString name, int age):
    m_role(role), m_name(name), m_age(age)
{

}

MemberList::MemberList(QObject *parent):
    QObject(parent)
{
    initList();
}

void MemberList::initList()
{
    QFile file("../Ex9/data.txt");
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qDebug() << "FILE is NULL";
        return;
    }

    while (!file.atEnd()) {
        QString line = file.readLine();
        Member member;
        eRole role = E_OTHER;

        if (line.contains("*Name")) {
            line = line.remove(0,7);
            line.replace("\n", "");
            member.setName(line);

            line = file.readLine();
            if (!line.contains("*Age"))
                continue;
            line = line.remove(0,6);
            member.setAge(line.toInt());

            line = file.readLine();
            if (!line.contains("*Role"))
                continue;
            line = line.remove(0,7);
            line.replace("\n", "");
            role = convertStringToRole(line);
            if(role == E_OTHER)
                continue;
            member.setRole(role);

            m_memList.push_back(member);
        }
    }

    file.close();
}

eRole MemberList::convertStringToRole(QString role)
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

QString MemberList::convertRoleToColor(eRole role)
{
    switch(role)
    {
    case E_BA:
        return "red";
    case E_TESTER:
        return "green";
    case E_DEVELOPER:
        return "blue";
    case E_LEADER:
        return "yellow";
    default:
        return "";
    }
}

QString MemberList::convertRoleToString(eRole role)
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

void MemberList::initListModel()
{
    for(std::vector<Member>::iterator it = m_memList.begin() ; it != m_memList.end(); ++it) {
        QMetaObject::invokeMethod(m_root, "addMember",
                              Q_ARG(QVariant, convertRoleToColor(it->getRole())),
                              Q_ARG(QVariant, it->getName()),
                              Q_ARG(QVariant, it->getAge()));
    }
}

void MemberList::declareRole()
{
    qmlRegisterType<MemberList>("MyEnum", 1, 0, "RoleEnum");
}

void MemberList::reWriteData()
{
    QFile file("../Ex9/data.txt");
    if (!file.open(QIODevice::WriteOnly  | QIODevice::Truncate)) {
        qDebug() << "FILE is NULL";
        return;
    }
    QString newFileData;
    QTextStream out(&file);

    for(std::vector<Member>::iterator it = m_memList.begin() ; it != m_memList.end(); ++it) {
        newFileData.append("*Name: "+it->getName()+"\n");
        newFileData.append("*Age: "+QString::number(it->getAge())+"\n");
        newFileData.append("*Role: "+convertRoleToString(it->getRole())+"\n");
        newFileData.append("\n");
    }

    file.resize(0);
    out << newFileData;
    file.close();
}

void MemberList::deleteMember(int index)
{
    m_memList.erase(m_memList.begin()+index);
    reWriteData();
}

void MemberList::updateMember(int index, QString name, int age, int role)
{
    m_memList[index].setName(name);
    m_memList[index].setAge(age);
    m_memList[index].setRole((eRole)role);

    reWriteData();
    initListModel();
}

void MemberList::addMember(QString name, int age, int role)
{
    Member member;
    member.setName(name);
    member.setAge(age);
    member.setRole((eRole)role);

    m_memList.push_back(member);
    reWriteData();
    QMetaObject::invokeMethod(m_root, "addMember",
                          Q_ARG(QVariant, convertRoleToColor((eRole)role)),
                          Q_ARG(QVariant, name),
                          Q_ARG(QVariant, age));
}
