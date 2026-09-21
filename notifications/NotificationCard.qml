import Quickshell
import Quickshell.Services.Notifications
import QtQuick
import QtQuick.Layouts

import qs
import qs.services
import qs.components
import "../utils.js" as Utils

Rectangle {
    id: root;

    readonly property var theme: ColorGenService.md3;

    property var n;

    property real w: 500;
    property real r: 10;
    property real p: 12;

    property color bg: theme.surface_container_highest;
    property color borderColor: "yellow";
    property color urgentColor: theme.error;
    property color dismissColor: theme.error;
    property color primaryTextColor: theme.on_surface;
    property color secondaryTextColor: theme.on_surface;
    property color hoverColor: theme.surface_container_high;

    implicitWidth: w;
    implicitHeight: content.implicitHeight + p * 2;

    color: hoverHandler.hovered && !btnClose.isHovered ? hoverColor : bg;
    radius: r;

    Behavior on color {
        ColorAnimation { duration: 200; }
    }

    Btn {
        id: btnClose;
        anchors {
            right: parent.right;
            top: parent.top
            bottom: parent.bottom;
        }

        label: "close";
        fontFamily: Theme.iconFontFamily;
        bg: Theme.get.red;
        bgHover: Theme.get.pink;
        fg: Utils.contrastColor(this.isHovered ? this.bgHover : this.bg);
        borderColor: Theme.get.background;
        topLeftRadius: 0;
        bottomLeftRadius: 0;

        onClick: NotifService.dismiss(n);
    }

    ColumnLayout {
        id: content;
        spacing: 10;

        anchors {
            left: parent.left;
            right: parent.right;
            top: parent.top;
            margins: root.p;
        }

        RowLayout {
            Layout.fillWidth: true;

            spacing: 10;

            Rectangle {
                id: iconBg;

                Layout.preferredWidth: 42;
                Layout.preferredHeight: 42;

                radius: 12;
                color: Qt.rgba(0, 0, 0, 0.16);

                Image {
                    anchors.centerIn: parent;
                    width: 26;
                    height: 26;
                    source: Quickshell.iconPath(root.n.appIcon || "", "preferences-desktop-notification-symbolic");
                    fillMode: Image.PreserveAspectFit;
                    smooth: true;
                }
            }

            ColumnLayout {
                Layout.fillWidth: true;
                spacing: 3;

                Text {
                    Layout.fillWidth: true;

                    text: n.summary;
                    color: root.primaryTextColor;
                    font.pixelSize: 15;
                    font.weight: Font.Medium;
                    font.family: Theme.fontFamily;
                    elide: Text.ElideRight;
                    maximumLineCount: 1;
                }

                Text {
                    Layout.fillWidth: true;
                    Layout.leftMargin: 20;

                    text: n.body || "No description provided (" + (n.appName || "") + ")";
                    color: root.secondaryTextColor;
                    font.family: Theme.fontFamily;
                    wrapMode: Text.Wrap;
                    maximumLineCount: 3;
                    elide: Text.ElideRight;
                }
            }

            // ensure the body content doesn't overflow and overlap
            // with the dismiss button
            Item {
                Layout.preferredWidth: btnClose.width;
                Layout.fillHeight: true;
            }
        }
    }

    HoverHandler {
        id: hoverHandler;
    }
}
