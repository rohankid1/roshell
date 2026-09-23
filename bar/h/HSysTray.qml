import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import QtQuick
import QtQuick.Layouts

import qs
import qs.services

Rectangle {
    id: root

    required property var wAnchor;

    readonly property var theme: ColorGenService.md3;
    readonly property var settings: SettingsService.get;

    property color background: theme.surface_container;
    property color borderColor: theme.outline;
    property color itemColor: theme.surface_container_high;

    implicitWidth: content.width + 20;
    implicitHeight: parent.height * 0.75;

    color: background;
    border.color: borderColor;
    radius: settings.general.borderRadius;

    Behavior on color {
        ColorAnimation { duration: settings.general.animations.colorAnimDuration; }
    }

    Behavior on border.color {
        ColorAnimation { duration: settings.general.animations.borderColorAnimDuration; }
    }

    RowLayout {
        id: content;
        anchors.centerIn: parent;
        spacing: 5;

        Repeater {
            model: SystemTray.items;

            delegate: Rectangle {
                id: trayItem;

                radius: 5;
                implicitWidth: 20;
                implicitHeight: 20;
                color: root.itemColor;

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

                Behavior on color {
                    ColorAnimation { duration: settings.general.animations.colorAnimDuration; }
                }
            }
        }
    }
}
