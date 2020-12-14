#ifndef MYSHAPE_H
#define MYSHAPE_H

#include <QObject>
#include <QDebug>
#include <QQmlEngine>



class MyShapee: public QObject
{
    Q_OBJECT
    Q_PROPERTY(eType type READ type WRITE setType NOTIFY typeChanged)
    Q_PROPERTY(int number READ number WRITE setNumber NOTIFY numberChanged)
    Q_PROPERTY(QString color READ color WRITE setColor NOTIFY colorChanged)

public:
    MyShapee(QObject* parent = nullptr);
    enum eType {
        E_BOX = 0,
        E_CIRCLE,
        E_TRIAGLE
    };
    Q_ENUMS(eType)

    eType type() {return m_type;}
    int number() {return m_number;}
    QString color() {return m_color;}

    void setType(eType type) {m_type = type;}
    void setNumber(int number) {m_number = number;}
    void setColor(QString color) {m_color = color;}
    void setRootObj(QObject* rootObj) {m_rootObj = rootObj;}

    void declareQML();

Q_SIGNALS:
    void typeChanged();
    void numberChanged();
    void colorChanged();

public slots:
    void addShape(eType type, int number, QString color);

private:
    eType m_type;
    int m_number;
    QString m_color;
    QObject* m_rootObj;
};

#endif // MYSHAPE_H
