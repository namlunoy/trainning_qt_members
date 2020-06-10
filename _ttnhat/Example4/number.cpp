#include "number.h"
Number::Number(QObject *parent): QObject(parent) {
    this->_count = 50;
}
int Number::count(){
    return this->_count;
}

void Number::setCount(int count){
    if (this->_count != count)
    {
        this->_count = count;
    }
    emit countChanged();
}

void Number::increaseCount(){
    int newCount = this->_count + 1;
    qDebug() << "Called increaseCount C++ slot";
    setCount(newCount);
}

void Number::decreaseCount()
{
    int newCount = this->_count - 1;
    qDebug() << "Called decreaseCount C++ slot";
    setCount(newCount);
}

void Number::setCountBtn(int newCount)
{
    qDebug() << "Called setCountBtn C++ slot";
    setCount(newCount);
}

void Number::resetCountBtn()
{
    qDebug() << "Called resetCountBtn C++ slot";
    setCount(50);
}
