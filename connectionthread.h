#ifndef CONNECTIONTHREAD_H
#define CONNECTIONTHREAD_H

#include <QObject>
#include <QThread>
#include <teclient.h>

class ConnectionThread : QThread
{
    Q_OBJECT
public:
    ConnectionThread();
    bool Connected = false;
    void setClient(TeClient client);
private:
    TeClient *Client;
    bool hasClient = false;

protected:
    void run() override;

signals:
    void ConnectedChanged();
};

#endif // CONNECTIONTHREAD_H
