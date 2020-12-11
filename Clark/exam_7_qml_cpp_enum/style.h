#ifndef STYLE_H
#define STYLE_H

#include <QObject>
#include <QQmlEngine>
#include <QtGlobal>

class StyleClass : public QObject
{
    Q_OBJECT
public:
    explicit StyleClass(QObject *parent = nullptr);

    enum EnStyle {
        RED,
        GREEN,
        BLUE
    };

    Q_ENUMS(EnStyle);

    static void declareQml() {
        qmlRegisterType<StyleClass>("CustomQmlEnum", 1, 0, "StyleClass");
    }

signals:

public slots:
};

#endif // STYLE_H
