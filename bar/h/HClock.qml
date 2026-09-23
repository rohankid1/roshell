import Quickshell
import QtQuick
import QtQuick.Layouts

import qs
import qs.services

Rectangle {
    id: root;

    readonly property var theme: ColorGenService.md3;
    readonly property var settings: SettingsService.get;

    property color background: theme.surface_container;
    property color foreground: theme.on_surface;
    property color iconColor: foreground;
    property color borderColor: theme.outline;

    property real borderRadius: settings.general.borderRadius;

    property string fontFamily: settings.font.family;
    property string iconFontFamily: settings.font.iconFamily;

    implicitHeight: parent.height * 0.75;
    implicitWidth: row.width + 20;

    radius: borderRadius;
    color: background;
    border.color: borderColor;

    Behavior on color {
        ColorAnimation { duration: settings.general.animations.colorAnimDuration; }
    }

    Behavior on border.color {
        ColorAnimation { duration: settings.general.animations.borderColorAnimDuration; }
    }

    RowLayout {
        id: row;
        anchors.centerIn: parent;

        Text {
            text: "schedule";
            color: root.iconColor;

            font.family: root.iconFontFamily;
            font.weight: Font.Bold;
            font.pixelSize: 20;
        }

        Text {
            text: ClockService.format("MMM d, yyyy");
            color: root.foreground;

            font.family: root.fontFamily;
        }

        Text {
            text: ClockService.format("hh:mm:ss");
            color: root.foreground;
            horizontalAlignment: Text.AlignHCenter;

            font.family: root.fontFamily;
        }
    }
}
