import QtQuick 2.4
import QtGraphicalEffects 1.0

Item {
    width: 400
    height: 400
    property url source: ""

    Rectangle {
        id: rectangle
        color: "#808080"
        radius: (width+height)/2
        anchors.fill: parent
    }


    Image {
        id: image
        anchors.fill: parent
        source: parent.source
        fillMode: Image.PreserveAspectCrop
        layer.enabled: true
        layer.effect: OpacityMask {
            anchors.fill: parent
            maskSource: rectangle
        }
    }
}
