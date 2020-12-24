#include "Member.h"

Member::Member(QObject *parent) :
    QObject(parent)
{
    m_role = E_BA;
    m_name = "";
    m_age = 0;
    m_id = 0;
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
