#ifndef CHARACTER_H
#define CHARACTER_H

#include <QObject>
#include <QDebug>
#include <QQmlEngine>

class MyCharacter: public QObject
{
    Q_OBJECT
    Q_PROPERTY(eChar character READ character WRITE setCharacter NOTIFY characterChanged)

public:
    MyCharacter(QObject* parent = nullptr);

    enum eChar {
        E_EREN = 0,
        E_LUFFY,
        E_NARUTO,
        E_SAITAMA,
        E_SONGOKU
    };
    Q_ENUMS(eChar)

    eChar character() {return m_character;}
    void setCharacter(eChar character);// {m_character = character;}

    void declareQML();

Q_SIGNALS:
    void characterChanged();

private:
    eChar m_character;
};

#endif // CHARACTER_H
