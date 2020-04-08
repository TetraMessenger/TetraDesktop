#include "connectionthread.h"

ConnectionThread::ConnectionThread()
{

}

void ConnectionThread::setClient(TeClient client){
    Client = &client;
    hasClient = true;
}

void ConnectionThread::run(){
    if(!hasClient)
        exit(1);
    Client->Pinged = false;
    Client->Send(Command::PingCommand().toString());
    wait(100000);
    if(!Client->Pinged){
        Connected = false;
        ConnectedChanged();
    }
    wait(4000000);
}
