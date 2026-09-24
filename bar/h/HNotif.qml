import Quickshell
import QtQuick
import QtQuick.Layouts

import qs
import qs.bar
import qs.services
import qs.notifications.services

Rectangle {
    id: root;

    required property var wAnchor;

    readonly property var theme: ColorGenService.md3;
    readonly property var settings: SettingsService.get;

    property color background: theme.surface_container;
    property color foreground: theme.on_surface;
    property color iconColor: foreground;
    property color borderColor: theme.outline;

    property string fontFamily: settings.font.family;
    property string iconFontFamily: settings.font.iconFamily;

    implicitHeight: parent.height * 0.75;
    implicitWidth: content.width + 20;

    radius: settings.general.borderRadius;
    color: background;
    border.color: borderColor;

    Behavior on color {
        ColorAnimation { duration: settings.general.animations.colorAnimDuration; }
    }

    Behavior on border.color {
        ColorAnimation { duration: settings.general.animations.borderColorAnimDuration; }
    }

    NotificationPopup {
        id: notifPopup;
        w: wAnchor;
        rectX: root.x + 20;
        rectY: root.y + 50;
    }

    MouseArea {
        anchors.fill: parent;

        onClicked: notifPopup.state = true;
    }

    RowLayout {
        id: content;
        anchors.centerIn: parent;

        Text {
            text: NotifService.isNotEmptyF ? "notifications_unread" : "notifications";
            color: root.foreground;

            font.family: root.iconFontFamily;
            font.weight: Font.Bold;
            font.pixelSize: 20;
        }

        Text {
            text: NotifService.filteredList.length;
            color: root.foreground;
        }
    }
}
