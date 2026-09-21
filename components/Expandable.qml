import Quickshell
import QtQuick
import QtQuick.Layouts

import qs
import qs.services

Item {
    id: root;

    property real w: 100;
    property real h: 35;
    property real wHover: w + 50;
    property real hHover: h + 100;
    property real borderRadius: Math.min(h / 2, 26);

    property bool shouldHorizontalCenter: true;
    property bool shouldVerticalCenter: true;

    property color bg: theme.background;
    property color border: theme.surface;

    readonly property bool hovered: hover.hovered;
    readonly property var theme: ColorGenService.md3;
    
    default property alias contents: rect.data;


    implicitWidth: w;
    implicitHeight: h;

    HoverHandler {
        id: hover;
    }

    Rectangle {
        id: rect;

        anchors.horizontalCenter: root.shouldHorizontalCenter ? parent.horizontalCenter : undefined;
        anchors.verticalCenter: root.shouldVerticalCenter ? parent.verticalCenter : undefined;

        color: root.bg;
        border.color: root.border;
        radius: root.borderRadius;
        width: root.hovered ? root.wHover : root.w;
        height: root.hovered ? root.hHover : root.h;

        Behavior on color {
            ColorAnimation { duration: 250; }
        }

        Behavior on width {
            SpringAnimation {
                mass: 1;
                spring: 5;
                damping: 0.75;
            }
        }

        Behavior on height {
            SpringAnimation {
                mass: 1;
                spring: 5;
                damping: 0.75;
            }
        }
    }
}
