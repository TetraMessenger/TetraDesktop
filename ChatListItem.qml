import QtQuick 2.4

Item {
    id: base
    width: 352
    height: 70
    signal click;

    RoundedImage {
        id: user_pic
        width: height
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 0
    }

    Text {
        id: username
        text: qsTr("Friend Name")
        renderType: Text.QtRendering
        font.weight: Font.Bold
        fontSizeMode: Text.Fit
        anchors.rightMargin: unread_border.width + 10
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.leftMargin: user_pic.width + 10
        anchors.top: parent.top
        anchors.topMargin: 5
        font.family: "Source Sans Pro"
        font.bold: true
        font.pixelSize: 24
    }

    Text {
        id: last_msg
        y: 61
        width: base.width - last_msg_time.width - user_pic.width - 40
        text: qsTr("last message in this conversation")
        renderType: Text.QtRendering
        elide: Text.ElideRight
        anchors.left: parent.left
        anchors.leftMargin: username.anchors.leftMargin
        font.family: "Source Sans Pro"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        font.pixelSize: 16
    }

    Text {
        id: last_msg_time
        x: 263
        y: 62
        text: qsTr("time")
        fontSizeMode: Text.FixedSize
        font.weight: Font.Normal
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.bottom: parent.bottom
        font.family: "Source Sans Pro"
        font.pixelSize: 18
        anchors.bottomMargin: 8
    }

    Rectangle {
        id: unread_border
        x: 360
        width: base.height / 3
        height: width
        color: "#0058ff"
        radius: 15
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 0

        Text {
            id: unread_count
            x: 4
            y: 8
            color: "#ffffff"
            text: qsTr("999")
            font.letterSpacing: 0.3
            renderType: Text.QtRendering
            fontSizeMode: Text.Fit
            horizontalAlignment: Text.AlignLeft
            elide: Text.ElideNone
            wrapMode: Text.NoWrap
            font.bold: false
            font.family: "source sans pro"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 11
        }
    }
    Item {
        id: layer0
        anchors.rightMargin: -25
        anchors.leftMargin: -25
        anchors.fill: base
        anchors.margins: -5

        clip: true

        Rectangle {
            id: overlay
            x: -width/4
            y: x
            radius: (width + height)
            width: base.width*2
            height: width
            color: "gray"
            border.width: 0
            opacity: 0
            layer.enabled: true
            Behavior on opacity { NumberAnimation { duration: 100} }
        }

        MouseArea {
            hoverEnabled: true
            anchors.fill: parent
            onReleased: {
                press.stop()
                release.stop()
                overlay.x = mouseX - overlay.width / 2
                overlay.y = mouseY - overlay.height / 2
                overlay.opacity = 0.5
                press.start()
                exit()
            }
            function exit() {
                release.start()
            }
            onEntered: overlay.opacity = 0.2
            onExited: {
                exit()
            }
            onClicked:{
                 base.click()
            }

            onPressed: {
                overlay.opacity = 0.4
            }
        }

    }


    NumberAnimation {
        target: overlay
        property: "opacity"
        id: release
        to: 0
        duration: 200
    }
    PropertyAnimation {
        id: press
        target: overlay
        property: "scale"
        from: 0
        to: 2
        duration: 900
        easing.type: Easing.OutInQuad
    }

}

/*##^##
Designer {
    D{i:1;anchors_height:80;anchors_x:8;anchors_y:14}D{i:2;anchors_x:109;anchors_y:10}
D{i:3;anchors_x:109}D{i:6;anchors_x:4;anchors_y:8}D{i:5;anchors_y:14}
}
##^##*/
