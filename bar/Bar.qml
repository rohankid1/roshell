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

PanelWindow {
    id: root;

    property var theme: ColorGenService.md3;
    readonly property var settings: SettingsService.get;
    readonly property bool isBottom: settings.shell.bar.position.trim().toLowerCase() === "bottom";

    WlrLayershell.namespace: "roshell-bar";
    WlrLayershell.layer: WlrLayer.Bottom;

    exclusionMode: ExclusionMode.Normal;
    exclusiveZone: 35;

    color: "transparent";
    implicitHeight: 50;

    anchors {
        bottom: root.isBottom;
        top: !root.isBottom;
        left: true;
        right: true;
    }

    Rectangle {
        anchors.fill: parent;
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
                wAnchor: root;
            }

            Item { Layout.fillWidth: true; }

            HSysTray {
                wAnchor: root;
            }

            HVolume {}
        }
    }
}
