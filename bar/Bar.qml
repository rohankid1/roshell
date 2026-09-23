import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import qs.bar.h
import qs.components
import qs.services
import qs.notifications.services

Rectangle {
    id: root;

    required property var windowAnchor;
    property var theme: ColorGenService.md3;
  
    color: theme.surface;

    RowLayout {
        id: row;

        anchors.fill: parent;
        anchors.leftMargin: 10;
        anchors.rightMargin: 10;

        HWorkspaces {}

        Item { Layout.fillWidth: true; }

        HClock {}

        HNotif {
            wAnchor: root.windowAnchor;
        }

        Item { Layout.fillWidth: true; }

        HSysTray {
            wAnchor: root.windowAnchor;
        }

        HVolume {}
    }
}
