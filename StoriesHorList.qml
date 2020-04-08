import QtQuick 2.4

Item {
    width: 400
    height: 118
    id: base
    function addStory(){
        var comp = Qt.createComponent("Story.qml");
        var story = comp.createObject(stories);
    }

    Text {
        text: qsTr("Stories")
        anchors.left: parent.left
        anchors.leftMargin: 0
        font.family: "Source Sans Pro Semibold"
        font.pixelSize: 18
        anchors.top: parent.top
        anchors.topMargin: 10
    }

    Text {
        color: "#0058ff"
        text: qsTr("See All")
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 10
        antialiasing: true
        renderType: Text.QtRendering
        smooth: true
        font.family: "Source Sans Pro Semibold"
        font.pixelSize: 18
    }

    Row {
        id: stories
        spacing: 5
        anchors.topMargin: 40
        anchors.fill: parent
    }
}

/*##^##
Designer {
    D{i:1;anchors_x:0;anchors_y:96}D{i:3;anchors_height:400;anchors_width:200}D{i:4;anchors_height:100;anchors_width:100}
}
##^##*/
