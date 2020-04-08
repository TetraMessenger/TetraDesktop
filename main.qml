import QtQuick 2.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0

ApplicationWindow {
    id: window
    visible: true
    width: 1100
    height: 700
    color: "#00000000"
    title: qsTr("Hello World")
    flags: Qt.FramelessWindowHint | Qt.Window

    onWidthChanged: {
            if(width <= 500)
                chat_view.width = width - 20
            else
                chat_view.width = 400
    }

    //onVisibleChanged:{ applicationData.start() }

    MouseArea {
        id: leftSideMouseArea
        property point lastMousePos: Qt.point(0, 0)
        width: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.top: parent.top
        cursorShape: Qt.SizeHorCursor
        anchors.topMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        onPressed: { lastMousePos = Qt.point(mouseX, mouseY); }
        onMouseXChanged: window.setWidth(Math.max(window.width + (mouseX + lastMousePos.x),400))
    }

    MouseArea {
        id: bottomSideMouseArea
        property point lastMousePos: Qt.point(0, 0)
        height: 10
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        cursorShape: Qt.SizeVerCursor
        anchors.right: parent.right
        anchors.rightMargin: 10
        onPressed: { lastMousePos = Qt.point(mouseX, mouseY); }
        onMouseYChanged: window.setHeight(Math.max(window.height + (mouseY + lastMousePos.y),400))
    }

    Rectangle {
        id: background
        color: "#ffffff"
        radius: 5
        border.width: 0
        anchors.fill: parent
        anchors.margins: window.visibility == ApplicationWindow.Maximized? 0 : 10

        GaussianBlur {
            x: 3
            radius: 2
            anchors.rightMargin: 0
            anchors.leftMargin: 2
            opacity: 0.25
            _alphaOnly: true
            transparentBorder: true
            source: chat_view
            anchors.fill: chat_view
        }

        Page {
            id: chat_view
            x: 0
            width: 400
            anchors.topMargin: 3
            anchors.leftMargin: 0
            clip: true
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.top: parent.top
            layer.enabled: true
            layer.effect: OpacityMask {
                maskSource: chat_view_back
                anchors.fill: chat_view
            }

            Rectangle {
                id: chat_view_back
                color: "#ffffff"
                radius: 5
                anchors.fill: parent
            }


            SwipeView {
                id: swipeView
                currentIndex: 1
                anchors.bottomMargin: 70
                anchors.topMargin: 120
                anchors.fill: parent
                onCurrentIndexChanged: {
                    if(currentIndex == 0)
                    {
                        chats_nav_icon.source = "chats_blue.png"
                        stories_nav_icon.source = "stories.png"
                    }
                    else
                    {
                        chats_nav_icon.source = "chats.png"
                        stories_nav_icon.source = "stories_blue.png"
                    }
                }

                Flickable {
                    x: 0
                    y: 120
                    contentY: 0
                    contentX: 0
                    flickableDirection: Flickable.VerticalFlick
                    interactive: true
                    contentHeight: chats_list.height + 50

                    Column {
                        id: chats_list
                        anchors.topMargin: 10
                        spacing: 10
                        anchors.rightMargin: 24
                        anchors.leftMargin: 24
                        anchors.right: parent.right
                        anchors.left: parent.left
                        anchors.top: parent.top

                        ChatListItem {
                            id: chatListItem
                            height: 70
                            anchors.left: parent.left
                            anchors.leftMargin: 0
                            anchors.right: parent.right
                            anchors.rightMargin: 0
                        }

                        ChatListItem {
                            height: 70
                            anchors.right: parent.right
                            anchors.rightMargin: 0
                            anchors.left: parent.left
                            anchors.leftMargin: 0
                        }

                        ChatListItem {
                            height: 70
                            anchors.right: parent.right
                            anchors.rightMargin: 0
                            anchors.left: parent.left
                            anchors.leftMargin: 0
                        }
                        ChatListItem {
                            height: 70
                            anchors.right: parent.right
                            anchors.rightMargin: 0
                            anchors.left: parent.left
                            anchors.leftMargin: 0
                        }
                        ChatListItem {
                            height: 70
                            anchors.right: parent.right
                            anchors.rightMargin: 0
                            anchors.left: parent.left
                            anchors.leftMargin: 0
                        }
                        ChatListItem {
                            height: 70
                            anchors.right: parent.right
                            anchors.rightMargin: 0
                            anchors.left: parent.left
                            anchors.leftMargin: 0
                        }

                        ChatListItem {
                            height: 70
                            anchors.rightMargin: 0
                            anchors.leftMargin: 0
                            anchors.left: parent.left
                            anchors.right: parent.right
                        }

                        ChatListItem {
                            height: 70
                            anchors.rightMargin: 0
                            anchors.leftMargin: 0
                            anchors.left: parent.left
                            anchors.right: parent.right
                        }

                        ChatListItem {
                            height: 70
                            anchors.rightMargin: 0
                            anchors.leftMargin: 0
                            anchors.left: parent.left
                            anchors.right: parent.right
                        }

                        ChatListItem {
                            height: 70
                            anchors.rightMargin: 0
                            anchors.leftMargin: 0
                            anchors.left: parent.left
                            anchors.right: parent.right
                        }

                        ChatListItem {
                            height: 70
                            anchors.rightMargin: 0
                            anchors.leftMargin: 0
                            anchors.left: parent.left
                            anchors.right: parent.right
                        }

                        ChatListItem {
                            height: 70
                            anchors.rightMargin: 0
                            anchors.leftMargin: 0
                            anchors.left: parent.left
                            anchors.right: parent.right
                        }
                    }

                }

                Flickable {
                    id: flickable
                    width: 300
                    height: 300
                    contentHeight: stories_list.height + 50
                    flickableDirection: Flickable.VerticalFlick

                    Column {
                        id: stories_list
                        anchors.right: parent.right
                        anchors.left: parent.left
                        anchors.top: parent.top
                        spacing: 10
                        anchors.topMargin: 10
                        anchors.rightMargin: 24
                        anchors.leftMargin: 24

                        ChatListItem {
                            id: chatListItem3
                            anchors.right: parent.right
                            anchors.rightMargin: 0
                            anchors.left: parent.left
                            anchors.leftMargin: 0
                        }

                        ChatListItem {
                            id: chatListItem4
                            anchors.right: parent.right
                            anchors.rightMargin: 0
                            anchors.left: parent.left
                            anchors.leftMargin: 0
                        }
                    }
                }

            }

            DropShadow {
                id: info_header_sh
                source: info_header_back
                anchors.fill: parent
                radius: {
                    var list = swipeView.currentItem
                    if(list.contentY <= 0)
                        return 0
                    else
                        return 10
                }

                horizontalOffset: 0
                fast: true
                verticalOffset: 0
                spread: 0
                samples: 20
                transparentBorder: true
            }

            Rectangle {
                id: info_header_back
                height: 120
                color: "#ffffff"
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.left: parent.left
                anchors.leftMargin: -2
                anchors.top: parent.top
                anchors.topMargin: 0
            }

            GaussianBlur {
                radius: 10
                opacity: 0.3
                _alphaOnly: true
                transparentBorder: true
                source: nav_bar
                anchors.fill: nav_bar
            }

            Rectangle {
                id: nav_bar
                x: -114
                y: 236
                height: 70
                color: "#ffffff"
                radius: 3
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
                anchors.left: parent.left
                anchors.leftMargin: -2
                anchors.right: parent.right
                anchors.rightMargin: 0

                Image {
                    id: search_nav_icon
                    x: 272
                    y: 10
                    width: 40
                    height: 40
                    sourceSize.height: 50
                    sourceSize.width: 50
                    anchors.right: parent.right
                    source: "search.png"
                    fillMode: Image.PreserveAspectFit
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.rightMargin: 100
                }


                Image {
                    id: settings_nav_icon
                    x: 338
                    y: 10
                    width: 40
                    height: 40
                    anchors.right: parent.right
                    anchors.rightMargin: 30
                    source: "settings.png"
                    fillMode: Image.PreserveAspectFit
                    anchors.verticalCenter: parent.verticalCenter
                }

                Image {
                    id: stories_nav_icon
                    x: 80
                    y: 10
                    width: 40
                    height: 40
                    source: "stories.png"
                    anchors.leftMargin: 100
                    anchors.left: parent.left
                    fillMode: Image.PreserveAspectFit
                    anchors.verticalCenter: parent.verticalCenter
                }

                Image {
                    id: chats_nav_icon
                    x: 14
                    y: 10
                    width: 40
                    height: 40
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 30
                    source: "chats.png"
                    fillMode: Image.PreserveAspectFit
                }



                MouseArea {
                    anchors.fill: stories_nav_icon
                    onClicked: {
                        swipeView.currentIndex = 1
                    }
                }

                MouseArea {
                    anchors.fill: chats_nav_icon
                    onClicked: {
                        swipeView.currentIndex = 0
                    }
                }
            }

            RoundedButton {
                id: roundedButton
                x: 36
                y: 196
                background: "#0058ff"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 30
                length: 80

                Image {
                    id: image
                    sourceSize.height: 50
                    sourceSize.width: 50
                    anchors.fill: parent
                    anchors.margins: 15
                    source: "plus.png"
                    fillMode: Image.PreserveAspectFit
                }
            }

            RoundedImage {
                id: roundedImage
                x: 295
                width: 50
                height: 50
                anchors.top: parent.top
                anchors.topMargin: 50
                anchors.right: parent.right
                anchors.rightMargin: 24
            }

            Text {
                id: user_name
                x: 24
                y: 53
                text: qsTr("Username")
                font.bold: true
                font.family: "Source Sans Pro"
                anchors.left: parent.left
                anchors.leftMargin: 24
                anchors.top: parent.top
                anchors.topMargin: 53
                font.pixelSize: 36
            }




        }

        WindowControls {
            id: action_bar
            height: 30
            radius: 5
            backColor: "#347bff"
            shadow_radius: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
        }



    }

    DropShadow {
        id: dropShadow
        anchors.fill: background
        horizontalOffset: 0
        verticalOffset: 0
        radius: action_bar.moving ? 10 : 5
        source: background
        color: "black"
        fast: true
        transparentBorder: true
        samples: 15
    }

}










/*##^##
Designer {
    D{i:35;anchors_height:100;anchors_width:100;anchors_x:36;anchors_y:196}D{i:36;anchors_height:100;anchors_width:100}
D{i:38;anchors_height:100;anchors_width:100}D{i:37;anchors_x:36;anchors_y:196}
}
##^##*/
