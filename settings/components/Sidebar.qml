import Quickshell
import QtQuick
import QtQuick.Layouts

import qs
import qs.services
import qs.components
import qs.settings

Rectangle {
    id: root;

    readonly property var theme: ColorGenService.md3;

    property string fontFamily: Theme.fontFamily;
    property string iconFontFamily: Theme.iconFontFamily;

    property color bg: theme.surface_container_low;
    property color fg: theme.on_surface;
    property color borderCol: theme.surface_container_high;

    property real w: 150;
    property real h: parent.height;
    property real r: 20;

    implicitWidth: w;
    implicitHeight: h;

    border.color: borderCol;
    color: bg;
    topRightRadius: r;
    bottomRightRadius: r;

    ColumnLayout {
        anchors.fill: parent;
        anchors.margins: 10;
        spacing: 10;

        Text {
            Layout.alignment: Qt.AlignTop | Qt.AlignHCenter;

            text: "RoShell";
            color: root.fg;

            font.family: root.fontFamily;
            font.weight: Font.Bold;
            font.pixelSize: Math.floor(root.w / 5);
        }

        ColumnLayout {
            Layout.fillWidth: true;
            Layout.fillHeight: true;
            spacing: 15;

            StyledButton {
                Layout.fillWidth: true;
                Layout.preferredHeight: 40;

                btnIcon: "settings";
                buttonColor: theme.primary;
                hoverColor: theme.primary_container;
                pressedColor: theme.primary;

                textColor: theme.on_primary;
                hoverTextColor: theme.on_primary_container;
                
                onClicked: WindowState.setPage(WindowState.general);
            }

            StyledButton {
                Layout.fillWidth: true;
                Layout.preferredHeight: 40;

                btnIcon: "wallpaper";
                buttonColor: theme.primary;
                hoverColor: theme.primary_container;
                pressedColor: theme.primary;

                textColor: theme.on_primary;
                hoverTextColor: theme.on_primary_container;

                onClicked: WindowState.setPage(WindowState.wallpaper);
            }

            StyledButton {
                Layout.fillWidth: true;
                Layout.preferredHeight: 40;

                btnIcon: "colors";
                buttonColor: theme.primary;
                hoverColor: theme.primary_container;
                pressedColor: theme.primary;

                textColor: theme.on_primary;
                hoverTextColor: theme.on_primary_container;

                onClicked: WindowState.setPage(WindowState.color);
            }

            Item {
                Layout.fillWidth: true;
                Layout.fillHeight: true;
            }
        }
    }
}
