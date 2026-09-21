import QtQuick

import qs
import qs.services

Rectangle {
    id: root;

    readonly property var theme: ColorGenService.md3;

    property int w: 100;
    property int h: 100;
    property int r: 10;
    property color bg: theme.background;
    property bool clickable: false;
    readonly property bool isHovered: hoverHandler.hovered;
    signal hover();
    signal click();

    function shouldScale(): bool {
        if (clickable) return mouseArea.containsMouse;
        else return mouseArea.containsMouse || hoverHandler.hovered;
    }

    implicitWidth: w;
    implicitHeight: h;
    radius: r;
    color: bg;
    scale: shouldScale() ? 0.90 : 1.0;

    Behavior on scale {
        SpringAnimation {
            spring: 5;
            damping: 0.7;
            mass: 1;
        }
    }

    HoverHandler {
        id: hoverHandler;
        onHoveredChanged: {
            if (this.hovered) {
                hover();
            }
        }
    }

    MouseArea {
        id: mouseArea;
        anchors.fill: parent;
        onClicked: click();
    }
}
