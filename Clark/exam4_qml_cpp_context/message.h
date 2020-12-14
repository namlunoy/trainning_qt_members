#ifndef MESSAGE_H
#define MESSAGE_H

#include <QObject>
#include <QDebug>

class Message : public QObject
{
    Q_OBJECT
//    Q_PROPERTY(QString author READ author WRITE setAuthor NOTIFY authorChanged)
    Q_PROPERTY(QString author READ author NOTIFY authorChanged)
public:
    explicit Message(QObject *parent = nullptr);

    void setAuthor(const QString &author) {
        if (author != m_author) {
            m_author = author;
            emit authorChanged();
        }
    }

    QString author() const {
        return m_author;
    }


signals:
    void authorChanged();
    void showText();
public slots:
    void reset()
    {
        m_author = "Clark";
        qDebug() << "reset is called";

        emit authorChanged();
        emit showText();
    }

    void set(QString str) {
        m_author = str;
        qDebug() << "set is called";

        emit authorChanged();
    }
private:
    QString m_author;
};

#endif // MESSAGE_H
