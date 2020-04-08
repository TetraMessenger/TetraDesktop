import QtQuick 2.4
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0

Item {
    id: element
    width: 400
    height: 25
    property color backColor: "white"
    property int radius: 10
    property int shadow_radius: 10
    property color shadow: "black"
    property bool moving: false
    signal onMaximized()

    Rectangle {
        id: background
        anchors.fill: parent
        color: parent.backColor
        radius: parent.radius

        Rectangle {
            id: bottom_left
            x: 0
            y: 15
            width: background.radius
            height: width
            color: background.color
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
        }

        Rectangle {
            id: bottom_right
            x: 390
            y: 15
            width: 10
            height: width
            color: background.color
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent;
        property variant clickPos: "1,1"

        onPressed: {
            clickPos = Qt.point(mouse.x,mouse.y)
            moving = true
        }

        onReleased: moving = false
        onDoubleClicked: ApplicationWindow.window.visibility = ApplicationWindow.Maximized
        onPositionChanged: {
            var mainWindow = ApplicationWindow.window
            var delta = Qt.point(mouse.x-clickPos.x, mouse.y-clickPos.y)
            var new_x = mainWindow.x + delta.x
            var new_y = mainWindow.y + delta.y
            if (new_y < 1)
            {
                mainWindow.visibility = ApplicationWindow.Maximized
                onMaximized()
            }
            else if(new_y > 11)
            {
                if (mainWindow.visibility === ApplicationWindow.Maximized){
                    var w = mainWindow.width
                    mainWindow.visibility = ApplicationWindow.Windowed
                    clickPos = Qt.point((mouseX/w)*mainWindow.width,clickPos.y)
                }
                else{
                mainWindow.x = new_x
                }
                mainWindow.y = new_y
            }
        }
    }

    RoundedButton {
        id: closer
        x: 377
        y: 3
        width: 20
        height: 20
        background: "#ff375f"
        ripple_color: "darkred"
        shadow_radius: 2
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 10
        length: 15
        onClick: ApplicationWindow.window.close()
    }

    RoundedButton {
        id: restorer
        x: 373
        y: 6
        width: 20
        height: 20
        background: "#ffd60a"
        ripple_color: "lightyellow"
        shadow_radius: 2
        anchors.verticalCenter: parent.verticalCenter
        length: 15
        anchors.right: parent.right
        anchors.rightMargin: 35
        onClick: ApplicationWindow.window.visibility === ApplicationWindow.Windowed ? ApplicationWindow.window.visibility = ApplicationWindow.Maximized : ApplicationWindow.window.visibility = ApplicationWindow.Windowed
    }

    RoundedButton {
        id: minimizer
        x: 381
        y: 6
        width: 20
        height: 20
        background: "#32d74b"
        shadow_radius: 2
        ripple_color: "lightgreen"
        anchors.verticalCenter: parent.verticalCenter
        length: 15
        anchors.right: parent.right
        anchors.rightMargin: 60
        onClick: ApplicationWindow.window.visibility = ApplicationWindow.Minimized
    }

}


