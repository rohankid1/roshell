import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

import qs
import qs.services
import qs.components

Rectangle {
    id: root;

    readonly property var theme: ColorGenService.md3;
    readonly property var settings: SettingsService.get;
    readonly property var barSettings: settings.shell.bar;

    property color bg: theme.surface_container;
    property color inactiveColor: theme.surface_container_highest;
    property color activeColor: theme.primary_container;
    property color inactiveBorderColor: theme.outline_variant;
    property color activeBorderColor: theme.outline;
    property color borderColor: theme.outline;

    property real borderRadius: settings.general.borderRadius;
    property real itemSpacing: 8;
    property real activeHeight: 16;
    property real inactiveHeight: 12;

    Layout.preferredHeight: parent.height * 0.75;
    Layout.preferredWidth: rowWs.width + 20;

    border.color: borderColor;
    color: bg
    radius: borderRadius;

    Behavior on color {
        ColorAnimation { duration: settings.general.animations.colorAnimDuration; }
    }

    Behavior on border.color {
        ColorAnimation { duration: settings.general.animations.borderColorAnimDuration; }
    }

    RowLayout {
        id: rowWs;
        spacing: root.itemSpacing;
        anchors.centerIn: parent;

        Repeater {
            model: barSettings.workspaces.automaticallyResize ? Hyprland.workspaces : root.settings.workspaces.maxStaticWorkspaces;

            Rectangle {
                id: rect;

                required property var modelData;
                readonly property bool isActive: {
                    if (typeof modelData === "object") return modelData.active;

                    const ws = Hyprland.workspaces.values.find(w => w.active);
                    return ws.id === modelData + 1;
                }

                color: isActive ? root.activeColor : root.inactiveColor;
                border.color: isActive ? root.activeBorderColor : root.inactiveBorderColor;
                radius: root.borderRadius;

                implicitHeight: isActive ? root.activeHeight : root.inactiveHeight;
                implicitWidth: implicitHeight;

                MouseArea {
                    anchors.fill: parent;
                    onClicked: {
                        if (typeof modelData === "object" && !modelData.active) {
                            modelData.activate();
                        } else if (typeof modelData === "number") {
                            Hyprland.dispatch(`hl.dsp.focus({ workspace = "${modelData + 1}" })`);
                        }
                    }
                }

                Behavior on color {
                    ColorAnimation { duration: 250; }
                }

                Behavior on border.color {
                    ColorAnimation { duration: 250; }
                }

                Behavior on implicitHeight {
                    NumberAnimation {
                        duration: 150;
                        easing.type: Easing.OutCubic;
                    }
                }
            }
        }
    }
}
