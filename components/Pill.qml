import QtQuick
import QtQuick.Layouts

import qs
import qs.services

Rectangle {
    id: root;

    property string icon: "";
    property string label: "";
    property string fontFamily: Theme.fontFamily;
    property string iconFontFamily: Theme.iconFontFamily;

    property color iconColor: theme.on_background;
    property color bgColor: theme.background;

    property int maxLabelWidth: 400;
    property int defaultWidth: -10; 
    property bool clickable: false;

    readonly property var theme: ColorGenService.md3;
    readonly property bool hovered: hover.hovered;
    readonly property bool clicked: internal.clicked;
    readonly property bool hoveredOrClicked: hovered || clicked;

    QtObject {
        id: internal;
        property bool clicked: false;
    }

    HoverHandler {
        id: hover;
        enabled: !clickable;
    }

    MouseArea {
        enabled: root.clickable;
        anchors.fill: parent;
        onClicked: () => {
            internal.clicked = !internal.clicked;
        }
    }

    implicitWidth: root.hoveredOrClicked ? row.implicitWidth + 22 : row.implicitWidth - root.defaultWidth;
    implicitHeight: 33;
    radius: height / 2;
    color: bgColor;
    border.color: {
        const a = theme.on_outline;
        const b = theme.outline;

        if (clickable) return clicked ? a : b;
        return hovered ? a : b;
    }
    clip: true;

    Behavior on border.color {
        ColorAnimation { duration: 200; }
    }

    Behavior on color {
        ColorAnimation { easing.type: Easing.InOutCubic; duration: 400; }
    }

    Behavior on implicitWidth {
        SpringAnimation { spring: 5; damping: 0.7; mass: 1; }
    }

    RowLayout {
        id: row;
        anchors.left: parent.left;
        anchors.verticalCenter: parent.verticalCenter;
        anchors.leftMargin: 8;
        spacing: 8;

        Text {
            text: root.icon;
            color: root.iconColor;
            font.family: root.iconFontFamily;
            font.pixelSize: 16;
        }

        Text {
            text: root.label;
            color: root.iconColor;
            font.family: root.fontFamily;
            font.pixelSize: 16;
            elide: Text.ElideRight;
            Layout.maximumWidth: root.maxLabelWidth;
            Layout.rightMargin: 8;
            visible: root.label !== "";
        }
    }
}
