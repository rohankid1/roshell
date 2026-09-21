import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

import qs
import qs.services

PopupWindow {
    id: root;

    readonly property var theme: ColorGenService.md3;

    required property var window;
    default property alias content: container.data;
    property string title: "";

    property real rectX: window.width / 2 - popupWidth / 2;
    property real rectY: window.height + 10;
    property real popupWidth: 500;
    property real popupHeight: 250;
    property real r: 20;

    property color fg: theme.on_background;
    property color bg: theme.background;
    property color borderColor: theme.outline;

    property bool state: false;

    implicitWidth: popupWidth;
    // implicitHeight: state ? popupHeight : popupHeight / 2;
    implicitHeight: popupHeight;
    anchor.window: window;
    anchor.rect.x: rectX;
    anchor.rect.y: rectY;
    visible: state;
    color: "transparent";

    HyprlandFocusGrab {
        active: state;
        windows: [root];
        onCleared: {
            state = false;
        }
    }

    Rectangle {
        id: rect;
        anchors.fill: parent;
        color: root.bg;
        radius: root.r;
        border.color: root.borderColor;
        focus: true;

        scale: root.state ? 1 : 0.92;
        opacity: root.state ? 1 : 0;

        Behavior on scale {
            SpringAnimation {
                mass: 1;
                spring: 4;
                damping: 0.2;
            }
        }

        Behavior on opacity {
            NumberAnimation { duration: 150; }
        }

        Keys.onPressed: event => {
            if (event.key === Qt.Key_Escape) {
                root.state = false;
            }
        }

        ColumnLayout {
            anchors.fill: parent;
            anchors.topMargin: 10;
            anchors.bottomMargin: 10;
            anchors.leftMargin: 5;
            anchors.rightMargin: 5;
            spacing: 5;

            Text {
                Layout.alignment: Text.AlignHCenter | Text.AlignTop;
                text: root.title;
                color: root.fg;
                font.family: Theme.fontFamily;
                font.pixelSize: 20;
                enabled: root.title !== "";
            }

            Item {
                id: container;
                Layout.fillWidth: true
                Layout.fillHeight: true;
            }
        }
    }
}
