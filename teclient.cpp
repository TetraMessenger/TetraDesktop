#include "teclient.h"
#include<QDebug>

QString User::GetData()
{
    QString blacklist = BlackList.join("\uAAAA");
    return "NAME" + Name + "\0PIDD" + ProfileID + "\0LTSN" + LastSeen.toString() + "\0EMAL"
            + Email + "\0PASS" + Password + "\0STTS" + About + "\0BLOK" + blacklist
            + "\0PICF" + ProfilePicture + "\0PICD" + ProfilePictureDate.toString() + "\0";
}

User User::Parse(QString data)
{
    User usr;
    QList<QString> dataList = data.split("\0");
    for (int i = 0; i< dataList.length(); i++)
    {
        try{
            QString key = dataList[i].mid(0,4);
            if(key == "NAME")
                usr.Name = dataList[i].mid(4);
            else if(key == "PIDD")
                usr.ProfileID = dataList[i].mid(4);
            else if(key == "LSTN")
                usr.LastSeen = QDateTime::fromString(dataList[i].mid(4));
            else if(key == "EMAL")
                usr.Email = dataList[i].mid(4);
            else if(key == "PASS")
                usr.Password = dataList[i].mid(4);
            else if(key == "STTS")
                usr.About = dataList[i].mid(4);
            else if(key == "PICT")
                usr.ProfilePicture = dataList[i].mid(4);
            else if(key == "PICD")
                usr.ProfilePictureDate = QDateTime::fromString(dataList[i].mid(4));
            else if(key == "BLOK")
                usr.BlackList = dataList[i].mid(4).split("\uAAAA");
        }
        catch(QException){}
    }
    return usr;
}

QString Message::GetData()
{
    return "DATA" + Content + "\0DATE" + Date.toString()
                    + "\0FROM" + From + "\0TTOO" + To + "\0LONG" + ID + "\0CTYP" + ChatType + "\0";
}

Message Message::Parse(QString data)
{
    Message msg;
    QList<QString> dataList = data.split("\0");
    for (int i = 0; i< dataList.length(); i++)
    {
        try{
            QString key = dataList[i].mid(0,4);
            if(key == "DATA")
                msg.Content = dataList[i].mid(4);
            else if(key == "DATE")
                msg.Date = QDateTime::fromString(dataList[i].mid(4));
            else if(key == "FROM")
                msg.From = dataList[i].mid(4);
            else if(key == "TTOO")
                msg.To = dataList[i].mid(4);
            else if(key == "LONG")
                msg.ID = dataList[i].mid(4).toLong();
            else if(key == "CTYP")
            {
                if(dataList[i].mid(4).toInt() == 0)
                    msg.ChatType = ChatType::Private;
                else msg.ChatType = ChatType::TGroup;
            }
        }
        catch(QException){}
    }
    return msg;
}

QString Group::GetData()
{
    return "TITL" + Title + "\0DESC" + About + "\0DATE" + CreatedDate.toString() + "\0GRID" + ID + "\0MEMS" + Members.join("\uF000");
}

Group Group::Parse(QString data)
{
    Group group;
    QList<QString> dataList = data.split("\0");
    for (int i = 0; i< dataList.length(); i++)
    {
        try{
            QString key = dataList[i].mid(0,4);
            if(key == "TITL")
                group.Title = dataList[i].mid(4);
            else if(key == "DESC")
                group.About = dataList[i].mid(4);
            else if(key == "DATE")
                group.CreatedDate = QDateTime::fromString(dataList[i].mid(4));
            else if(key == "GRID")
                group.ID = dataList[i].mid(4).toLong();
            else if(key == "MEMS")
                group.Members = dataList[i].mid(4).split("\uF000");
        }
        catch(QException){}
    }
    return group;
}

void TeClient::RegisterRequest(User user){
    Command command("CUSR",user.GetData());
    Send(command.toString());
}

Command::Command(QString Name,QString Args)
{
    this->Name = Name;
    this->Args = Args;
}

Command Command::PingCommand()
{
    return Command("PING","");
}

QString Command::toString()
{
    return Name + "\uFFFF" + Args;
}

Command::Command(){}

Command Command::Parse(QString data)
{
    QList<QString> dataList = data.split("\uFFfF");
    if(dataList.length()>2) return Command();
    return Command(dataList[0],dataList[1]);
}

TeClient::TeClient()
{
    // QSslSocket emits the encrypted() signal after the encrypted connection is established
    connect(&socket, SIGNAL(encrypted()), this, SLOT(connectedToServer()));

    // Report any SSL errors that occur
    connect(&socket, SIGNAL(sslErrors(const QList<QSslError> &)), this, SLOT(sslErrors(const QList<QSslError> &)));

    connect(&socket, SIGNAL(disconnected()), this, SLOT(connectionClosed()));
    connect(&socket, SIGNAL(readyRead()), this, SLOT(receiveMessage()));
    connect(&socket, SIGNAL(error(QAbstractSocket::SocketError)), this, SLOT(socketError()));

}

void TeClient::Connect()
{
    socket.ignoreSslErrors();
    socket.connectToHostEncrypted(TeClient::URL_windowsclient_tcp,TeClient::PORT_windowsclient_tcp);
}

void TeClient::Send(QString command){
    socket.write(command.toLocal8Bit());
    socket.flush();
}

void TeClient::Send(QByteArray command){
    socket.write(command);
    socket.flush();
}

void TeClient::connectedToServer()
{
    qInfo("Connected");
}

// Process SSL errors
void TeClient::sslErrors(const QList<QSslError> &errors)
{
    socket.ignoreSslErrors(errors);
   qInfo(errors[0].errorString().toUtf8());
}

void TeClient::receiveMessage()
{
    QString msg = socket.readAll();
    Command cmd = Command::Parse(msg);
    if(cmd.Name == "PING")
        Pinged = true;
    else{

    }
}

void TeClient::connectionClosed()
{
    qInfo("Closed");
}

void TeClient::socketError()
{
    qInfo(socket.errorString().toUtf8());
}
