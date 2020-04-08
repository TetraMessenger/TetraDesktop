import QtQuick 2.4
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.0

Item {
    width: 65
    height: 65

    Rectangle {
        id: rectangle
        color: "#00000000"
        radius: 32.5
        border.width: 4
        border.color: "#0058ff"
        anchors.fill: parent
    }

    RoundedImage {
        id: user_pic
        anchors.rightMargin: 5
        anchors.leftMargin: 5
        anchors.bottomMargin: 5
        anchors.topMargin: 5
        anchors.fill: parent
        Behavior on scale {
            PropertyAnimation {
                duration: 100
                easing.type: Easing.OutCirc }}
    }

    MouseArea {
        id: mouseArea
        hoverEnabled: true
        anchors.fill: parent
        onExited: user_pic.scale = 1
        onReleased: user_pic.scale = 1
        onPressed: user_pic.scale = 0.9
    }

}

/*##^##
Designer {
    D{i:1;anchors_height:200;anchors_width:200;anchors_x:8;anchors_y:8}D{i:2;anchors_height:60;anchors_width:60;anchors_x:0;anchors_y:8}
D{i:3;anchors_height:100;anchors_width:100}
}
##^##*/
