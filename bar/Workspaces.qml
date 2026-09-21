import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

import qs
import qs.services

Rectangle {
    id: root;

    readonly property var theme: ColorGenService.md3;

    property color bg: theme.background;
    property color borderColor: theme.outline;
    
    implicitWidth: row.implicitWidth + 22;
    implicitHeight: 33;
    radius: height / 2;
    color: bg;
    border.color: borderColor;

    RowLayout {
        id: row;
        anchors.centerIn: parent;
        spacing: 8;

        Repeater {
            model: Hyprland.workspaces;

            Rectangle {
                required property var modelData;

                implicitWidth: modelData.active ? 12 : 6;
                implicitHeight: implicitWidth;
                radius: width / 2;
                color: modelData.active ? "transparent" : root.theme.on_background;
                border.width: modelData.active ? 2 : 0;
                border.color: theme.outline_variant;

                Behavior on implicitWidth {
                    NumberAnimation { duration: 160; easing.type: Easing.OutCubic; }
                }

                MouseArea {
                    anchors.fill: parent;
                    enabled: !modelData.active;

                    onClicked: () => {
                        modelData.activate();
                    };
                }
            }
        }
    }
}
