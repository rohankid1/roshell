import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts

import qs
import qs.services
import "components"
import "pages"

FloatingWindow {
    id: root;

    readonly property var theme: ColorGenService.md3;

    property color fg: theme.on_background;
    property color bg: theme.background;
    // property color surface: ColorGenService.surface;

    title: "RoSettings";
    minimumSize: "500x500";
    maximumSize: "1000x800";
    color: "transparent";
    visible: false;

    IpcHandler {
        target: "settings";

        function toggle(): void {
            root.visible = !root.visible;
        }
    }

    Rectangle {
        id: rect;
        anchors.fill: parent;

        focus: true;
        activeFocusOnTab: true;

        color: root.bg;

        Behavior on color {
            ColorAnimation { duration: 500; easing.type: Easing.InOutQuad; }
        }

        Sidebar {
            id: sidebar;
        }

        RowLayout {
            anchors.fill: parent;

            SequentialAnimation {
                id: animation;

                NumberAnimation {
                    target: loader;
                    property: "x";
                    to: root.width;
                    duration: 150;
                    easing.type: Easing.InQuad;
                }

                ScriptAction {
                    script: loader.source = WindowState.activeTab;
                }

                NumberAnimation {
                    target: loader;
                    property: "x";
                    to: sidebar.width + 20;
                    duration: 150;
                    easing.type: Easing.OutQuad;
                }
            }

            Loader {
                id: loader;

                Layout.alignment: Qt.AlignTop | Qt.AlignLeft;
                Layout.fillWidth: true;
                Layout.fillHeight: true;
                Layout.leftMargin: sidebar.width + 20;
                Layout.rightMargin: 10;
                Layout.topMargin: 10;

                source: WindowState.general;
            }

            Connections {
                target: WindowState;

                function onPage(newPage: string): void {
                    animation.start();
                }
            }
        }

    }
}
