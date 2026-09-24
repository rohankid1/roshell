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
    readonly property bool isVertical: settings.shell.bar.vertical;

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

            Bar {
                visible: !root.isVertical;
                screen: scope.modelData;
            }
        }
    }
}
