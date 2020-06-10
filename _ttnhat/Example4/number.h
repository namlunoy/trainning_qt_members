#include <QObject>
#include <QDebug>

class Number : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int count READ count WRITE setCount NOTIFY countChanged)

public:
    Number(QObject *parent = nullptr);
    void setCount(int count);
    int count();
    signals:
        void countChanged();
public slots:
        void increaseCount();
        void decreaseCount();
        void setCountBtn(int newCount);
        void resetCountBtn();

private:
    int _count;
};
