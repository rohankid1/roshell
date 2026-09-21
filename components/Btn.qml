import QtQuick
import QtQuick.Controls

import qs
import qs.services

Button {
    id: root;

    readonly property alias isHovered: hover.hovered;
    readonly property var theme: ColorGenService.md3;

    property string label: "";
    property string fontFamily: Theme.fontFamily;

    property color bg: theme.primary;
    property color fg: theme.on_primary;
    property color bgHover: theme.inverse_primary;
    property color borderColor: theme.outline;
    property color borderHoverColor: theme.outline_variant;

    property real bRadius: 20;
    property real topLeftRadius: 20;
    property real topRightRadius: 20;
    property real bottomLeftRadius: 20;
    property real bottomRightRadius: 20;

    signal click();

    HoverHandler {
        id: hover;
    }

    text: label;
    flat: true;
    scale: pressed ? 0.90 : 1.0;
    opacity: enabled ? 1.0 : 0.5;

    Behavior on opacity {
        NumberAnimation {
            duration: 150;
        }
    }

    Behavior on scale {
        SpringAnimation {
            spring: 5;
            damping: 0.7;
            mass: 1;
        }
    }
    
    contentItem: Text {
        text: root.label;
        color: root.fg;
        font.family: root.fontFamily;
        verticalAlignment: Qt.AlignVCenter;
        horizontalAlignment: Qt.AlignHCenter;
    }             
    background: Rectangle {
        border.color: root.enabled ? (hover.hovered ? root.borderHoverColor: root.borderColor ) : root.borderColor;
        color: root.enabled ? (hover.hovered ? root.bgHover : root.bg) : root.bg;
        radius: root.bRadius;
        bottomLeftRadius: root.bottomLeftRadius;
        bottomRightRadius: root.bottomRightRadius;
        topLeftRadius: root.topLeftRadius;
        topRightRadius: root.topRightRadius;        

        Behavior on color {
            ColorAnimation { duration: 250; }
        }
    }
    onClicked: root.click();
}
