#ifndef TECLIENT_H
#define TECLIENT_H

#include<QObject>
#include<QSslSocket>
#include<QtCore>
#include<QtWidgets>

class User{
public:
    QString Name;
    QString Email;
    QString Password;
    QString ProfileID;
    QString About;
    QDateTime LastSeen;
    QString ProfilePicture;
    QDateTime ProfilePictureDate;
    QList<QString> BlackList;
    int SererID;
    QString GetData();
    static User Parse(QString data);
};

enum ChatType{ Private = 0, TGroup = 1};

class Message{
public:
    QDateTime Date;
    QString Content;
    QString From;
    ChatType ChatType;
    QString To;
    long ID;
    bool Recieved;
    QString GetData();
    static Message Parse(QString data);
};

class Group{
public:
    QString Title;
    QString About;
    QDateTime CreatedDate;
    long ID;
    QList<QString> Members;
    QString GetData();
    static Group Parse(QString data);
};

class Command{
public:
    QString Name;
    QString Args;
    static Command PingCommand();
    Command(QString Name,QString Args);
    Command();
    QString toString();
    static Command Parse(QString data);
};

class TeClient : QObject
{
    Q_OBJECT
public:
    TeClient();
    void RegisterRequest(User info);
    void Login(QString email, QString password);
    void Connect();
    void Send(QString command);
    void Send(QByteArray command);
    bool Pinged;

    enum class LoginStatus { Email_Error = 0, Password_Error, Success };
    enum class RegisterStatus { PofileID_Error = 0, Email_Error, Success };
    enum class ConnectStatus { Old_Version = 0, Server_Uncorrect = 1, Success = 2 };
    enum class MessageSet { Received = 0, Deleted = 1 };
    enum class FileSendTask { Upload_File = 0, Upload_ProfilePicture = 1, Upload_Story = 2, Upload_RecorededSound = 3, Upload_GroupPicture = 4 };
    enum class Connection_Status { Disconnected = 0, Connected = 1, Connecting = 2 };

signals:
    void NewMessageCallback(QList<Message>* messages);
    void MessageSetCallback(QList<int> IDs, MessageSet MS);
    void LoginCallback(LoginStatus status);
    void RegisterCallback(RegisterStatus status);
    void ConnectCallback(ConnectStatus status);
    void LastSeen_Get(QString lastseen, QString PID);
    void ProfilePic_Get(QString date, QString filename, QString PID);
    void PIDINFO_Get(QString PID, User info);
    void FILE_Get(int spcID, QString path);

public slots:
    void connectedToServer();
    void sslErrors(const QList<QSslError> &);
    void receiveMessage();
    void connectionClosed();
    void socketError();

private:
    void Thread_Connect();
    User CLI_INFO;
    Connection_Status status = Connection_Status::Disconnected;
    QString pendingList;
    QList<QString> log;
    QString profilePictureDirectory;
    QString mediaDirectory;
    QSslSocket socket;
    QString URL_windowsclient_tcp = "127.0.0.1";
    QString URL_windowsclient_ftp = "localhost";
    int PORT_windowsclient_tcp = 42534;
    int PORT_windowsclient_ftp = 42535;
};

#endif // TECLIENT_H
