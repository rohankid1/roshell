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

    WlrLayershell.namespace: "quickshell:roshell-bar-horizontal";
    WlrLayershell.layer: WlrLayer.Top;

    exclusionMode: ExclusionMode.Normal;
    exclusiveZone: 35;

    color: "transparent";
    implicitHeight: 40;

    anchors {
        bottom: root.isBottom;
        top: !root.isBottom;
        left: true;
        right: true;
    }

    margins.right: 5;
    margins.left: 5;
    margins.top: 5;
    margins.bottom: 5;

    Rectangle {
        anchors.fill: parent;
        color: theme.surface;
        radius: settings.shell.bar.radius;

        RowLayout {
            id: row;

            anchors.fill: parent;
            anchors.margins: 10;

            Item {
                Layout.fillWidth: true;
                Layout.fillHeight: true;

                HWorkspaces {
                    bg: "transparent";
                    borderColor: "transparent";
                    inactiveColor: "transparent";
                    inactiveBorderColor: "transparent";
                    activeBorderColor: "transparent";
                }
            }

            Item { Layout.fillWidth: true; }

            HNotif {
                wAnchor: root;
                borderColor: "transparent";
                background: "transparent";
            }

            HVolume {
                background: "transparent";
                borderColor: "transparent";
            }

            Item { Layout.fillWidth: true; }

            Item {
                Layout.fillWidth: true;
                Layout.fillHeight: true;

                HClock {
                    anchors.verticalCenter: parent.verticalCenter;
                    anchors.right: parent.right;

                    background: "transparent";
                    borderColor: "transparent";
                    showIcon: false;
                }
            }

            HSysTray {
                wAnchor: root;
                background: "transparent";
                borderColor: "transparent";
            }
        }
    }
}
