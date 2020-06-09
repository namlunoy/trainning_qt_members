#include "clocktimer.h"

ClockTimer::ClockTimer(QObject *parent) : QObject(parent)
{
    m_timer = new QTimer(this);

}

void ClockTimer::setTimer()
{
    qDebug() << "setTimer() is called.";
    m_timer->setInterval(1000);
    connect(m_timer, &QTimer::timeout, this, &ClockTimer::handleTimeOut);
    m_timer->start();
}

void ClockTimer::stopTimer()
{
    m_timer->stop();
}


void ClockTimer::handleTimeOut()
{
    qDebug() << "on timer out!";
    m_sec--;
    if(m_sec < 0)
    {
        m_sec = 59;
        m_min--;
    }
    Q_EMIT minuteChanged();
    Q_EMIT secondChanged();
}
