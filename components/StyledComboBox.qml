import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import qs;
import qs.services;

ComboBox {
    id: root;

    readonly property var theme: ColorGenService.md3;

    property int w: 180;
    property int h: 42;
    property int fontSize: 14;
    property int indicatorSize: 18;
    property int radius: 12;

    property color bg: theme.surface_container_highest;
    property color bg2: theme.surface_container;
    property color fg: theme.on_surface;
    property color indicatorColor: theme.on_surface_variant;
    property color borderColorActive: theme.primary;
    property color borderColor: theme.outline_variant;
    property color popupColor: theme.surface_container;
    property color popupBorderColor: theme.outline_variant;

    property string fontFamily: Theme.fontFamily;
    property string iconFontFamily: Theme.iconFontFamily;

    implicitWidth: w;
    implicitHeight: h;
    font.family: fontFamily;
    font.pixelSize: fontSize;
    opacity: enabled ? 1.0 : 0.6;

    contentItem: Text {
        text: root.displayText;
        color: root.fg;
        font: root.fontFamily;
        verticalAlignment: Text.AlignVCenter;
        leftPadding: 14;
        rightPadding: 40;
        elide: Text.ElideRight;
    }

    background: Rectangle {
        radius: root.radius;
        color: root.popup.visible ? root.bg : root.bg2;

        border.width: root.activeFocus ? 2 : 1;
        border.color: root.activeFocus ? root.borderColorActive : root.borderColor;

        Behavior on color {
            ColorAnimation { duration: 250; }
        }

        Behavior on border.color {
            ColorAnimation { duration: 250; }
        }
    }

    indicator: Text {
        x: root.w - width - 12;
        y: (root.h - height) / 2;

        text: root.popup.visible ? "󰅀" : "󰅃";
        color: root.indicatorColor;
        font.family: root.iconFontFamily;
        font.pixelSize: root.indicatorSize;
    }

    popup: Popup {
        y: root.h + 6;
        width: root.w;
        padding: 4;

        background: Rectangle {
            radius: root.radius;
            color: root.popupColor;

            border.width: 1;
            border.color: root.popupBorderColor;
        }

        contentItem: ListView {
            implicitHeight: Math.min(contentHeight, 240);
            model: root.delegateModel;
            clip: true;

            ScrollBar.vertical: ScrollBar {}
        }
    }

    delegate: ItemDelegate {
        HoverHandler {
            id: hover;
        }

        required property var modelData;
        readonly property bool isHovered: hover.hovered;

        width: root.w - 8;
        height: 40;

        font.family: root.fontFamily;
        font.pixelSize: root.fontSize;

        contentItem: Text {
            text: modelData[root.textRole];
            color: root.fg;
            font: parent.font;
            verticalAlignment: Text.AlignVCenter;
            leftPadding: 10;
        }

        background: Rectangle {
            radius: 8;

            color: parent.isHovered ? root.bg : "transparent";
        }
    }
}
