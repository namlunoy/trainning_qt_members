#ifndef CLOCKTIMER_H
#define CLOCKTIMER_H

#include <QObject>
#include <QTimer>
#include <QDebug>

class ClockTimer : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int minute READ minute WRITE setMinute NOTIFY minuteChanged)
    Q_PROPERTY(int second READ second WRITE setSecond NOTIFY secondChanged)
public:
    explicit ClockTimer(QObject *parent = nullptr);
    int minute() { return m_min; }
    int second() { return m_sec; }
    void setMinute(int min) {
        qDebug() << "setMinute() is called";
        m_min = min;
        //send signal to notify change
        Q_EMIT minuteChanged();
    }
    void setSecond(int sec) {
        qDebug() << "setSecond() is called";
        m_sec = sec;
        //send signal to notify change
        Q_EMIT secondChanged();
    }
    Q_INVOKABLE void setTimer();
    Q_INVOKABLE void stopTimer();
signals:
    void minuteChanged();
    void secondChanged();

public slots:
    void handleTimeOut();
private:
    int m_min;
    int m_sec;
    QTimer *m_timer;
};



#endif // CLOCKTIMER_H
