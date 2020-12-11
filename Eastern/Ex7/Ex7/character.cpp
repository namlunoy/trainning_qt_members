#include "character.h"

MyCharacter::MyCharacter(QObject* parent):
    QObject(parent)
{
    m_character = E_EREN;
}

void MyCharacter::setCharacter(MyCharacter::eChar character)
{
    m_character = character;
    Q_EMIT characterChanged();
}

void MyCharacter::declareQML()
{
    qmlRegisterType<MyCharacter>("MyEnum", 1, 0, "CharacterEnum");
}
