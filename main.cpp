#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>
#include <QDebug>
#include <teclient.h>
#include <QQmlContext>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    //This has QPixmap images use the @2x images when available
    //See this bug for more details on how to get this right: https://bugreports.qt.io/browse/QTBUG-44486#comment-327410
    QCoreApplication::setAttribute(Qt::AA_UseHighDpiPixmaps);


    QGuiApplication app(argc, argv);

    QUrl url(QStringLiteral("qrc:/main.qml"));

    QQmlApplicationEngine engine;
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    engine.load(url);

    User user;
    user.Name = "Anas";
    user.Email = "anas@gmail.com";
    user.Password = "anastaleb";
    user.ProfileID = "anast9";

    TeClient client;
    client.Connect();
    client.RegisterRequest(user);

    return app.exec();
}
