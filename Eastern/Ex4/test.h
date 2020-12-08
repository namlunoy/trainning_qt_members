#ifndef TEST_H
#define TEST_H

#include <QObject>
#include <QDebug>

class MyClass : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int val READ val WRITE setVal NOTIFY valChanged)

public:
    MyClass(QObject* parent = nullptr);

    int val() {return m_val;}
    void setVal(int val) {m_val = val;}

Q_SIGNALS:
    void valChanged();

public slots:
    void increase();
    void decrease();
    void reset();
    void set();

private:
    int m_val;
};

#endif // TEST_H
