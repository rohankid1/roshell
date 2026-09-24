//@ pragma UseQApplication
import Quickshell
import Quickshell.Wayland
import QtQuick

import "desktopwidgets";
import "notifications"
import "components"
import "services"
import "settings"
import "wpicker"
import "bar"

ShellRoot {
    id: root;

    readonly property var settings: SettingsService.get;
    readonly property bool isBottom: settings.shell.bar.position.trim().toLowerCase() === "bottom";

    WallpaperPicker {}
    SettingsWindow {}

    Variants {
        model: Quickshell.screens;

        Scope {
            id: scope;
            required property ShellScreen modelData;

            DesktopWindow {
                monitor: modelData;
            }

            PanelWindow {
                id: panelwindow;
                screen: scope.modelData;
                color: "transparent";
                implicitHeight: 50;

                anchors {
                    bottom: root.isBottom;
                    top: !root.isBottom;
                    left: true;
                    right: true;
                }

                Bar {
                    id: bar;
                    anchors.fill: parent;
                    windowAnchor: panelwindow;
                }

                WlrLayershell.namespace: "roshell-bar";
                WlrLayershell.layer: WlrLayer.Bottom;
                exclusionMode: ExclusionMode.Normal;
                exclusiveZone: 35;
            }
        }
    }
}
