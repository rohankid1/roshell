import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import QtQuick
import QtQuick.Layouts

import qs
import qs.services

Rectangle {
    required property var window;

    readonly property var theme: ColorGenService.md3;

    property color bg: theme.background;
    property color borderColor: theme.outline;
    property color trayBg: theme.surface;

    id: root;
    implicitWidth: row.implicitWidth + 22;
    implicitHeight: 33;
    radius: height / 2;
    color: bg;
    border.color: borderColor;

    RowLayout {
        id: row;
        anchors.centerIn: parent;
        spacing: 5;

        Repeater {
            model: SystemTray.items;

            delegate: Rectangle {
                id: trayItem;

                radius: 5;
                width: 20;
                height: 20
                color: root.trayBg;

                IconImage {
                    anchors.fill: parent;
                    source: modelData.icon;
                }

                MouseArea {
                    anchors.fill: parent;

                    acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton;
                    onClicked: mouse => {
                        if (mouse.button === Qt.LeftButton) {
                            menuAnchor.activate();
                        } else if (mouse.button === Qt.MiddleButton) {
                            menuAnchor.secondaryActivate();
                        } else {
                            if (modelData.hasMenu) {
                                menuAnchor.open();
                            }
                        }
                    };
                }

                QsMenuAnchor {
                    id: menuAnchor;

                    menu: modelData.menu;

                    anchor.window: trayItem.QsWindow.window;
                    anchor.adjustment: PopupAdjustment.Flip;
                    anchor.onAnchoring: {
                        const w = trayItem.QsWindow.window;
                        const rect = w.contentItem.mapFromItem(
                            trayItem, 0, trayItem.height,
                            trayItem.width, trayItem.height
                        );

                        this.anchor.rect = rect;
                    }
                }
            }
        }
    }
}
