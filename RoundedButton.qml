import QtQuick 2.9
import QtGraphicalEffects 1.0

Item {
    width: length
    height: length
    id: base
    property int radius: 200
    property int shadow_radius: 10
    property color background: "#000000"
    property color ripple_color: "#ffffff"
    property int length: 400
    signal click();

    GaussianBlur {
        radius: base.shadow_radius
        anchors.fill: parent
        transparentBorder: true
        source: background
        _color: base.background
        _alphaOnly: true
    }

    Rectangle {
        id: background
        color: base.background
        radius: base.radius
        anchors.fill: parent

    }

    Item {
        id: layer0
        anchors.fill: background
        clip: true
        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: background
            anchors.fill: parent
        }

        Rectangle {
            id: overlay
            x: 0
            y: 0
            radius: (width + height)
            width: base.width
            height: base.height
            color: base.ripple_color
            border.width: 0
            opacity: 0
            layer.enabled: true
        }

        MouseArea {
            anchors.fill: parent
            layer.enabled: true
            layer.effect: OpacityMask {
                maskSource: background
                anchors.fill: parent

            }
            onReleased: exit()
            function exit() {

                release.start()
            }

            onClicked:{
                var x1 = (width) / 2
                var y1 = (height) / 2
                var x2 = mouseX
                var y2 = mouseY
                var distanceFromCenter = Math.pow(x1 - x2, 2) + Math.pow(y1 - y2, 2)
                var radiusSquared = Math.pow(Math.max(width, height)/2 + (Math.max(width, height)/2 - base.radius) , 2)
                if(distanceFromCenter > radiusSquared)
                    return
                 base.click()
            }

            onPressed: {
                var x1 = (width) / 2
                var y1 = (height) / 2
                var x2 = mouseX
                var y2 = mouseY
                var distanceFromCenter = Math.pow(x1 - x2, 2) + Math.pow(y1 - y2, 2)
                var radiusSquared = Math.pow(Math.max(width, height)/2 + (Math.max(width, height)/2 - base.radius*1.1) , 2)
                if(distanceFromCenter > radiusSquared)
                    return
                press.stop()
                release.stop()
                overlay.x = mouseX - overlay.width / 2
                overlay.y = mouseY - overlay.height / 2
                overlay.opacity = 0.5
                press.start()
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
            easing.type: Easing.OutCirc
        }

}

