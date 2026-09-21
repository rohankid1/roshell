import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import qs.components
import qs.services
import qs.notifications.services

Item {
    required property var windowAnchor;

    NotificationPopup {
        id: notifWindow;
        w: windowAnchor;
        rectX: notifPill.x;
        rectY: notifPill.y + 50;
    }

    Popup {
        id: screenWindow;
        window: windowAnchor;
        rectX: screenPill.x;
        rectY: screenPill.y + 50;

        ColumnLayout {
            anchors.fill: parent;

            ScreencopyView {
                Layout.fillWidth: true;
                Layout.fillHeight: true;

                id: preview;

                live: true;
                captureSource: Quickshell.screens[0];
                paintCursor: true;
            }
        }
    }

    ColumnLayout {
        anchors.fill: parent;

        RowLayout {
            Layout.fillWidth: true;
            Layout.fillHeight: true;
            Layout.topMargin: 10;

            spacing: 10;

            Workspaces {}

            Pill {
                id: screenPill;
                icon: "airplay";
                label: "Screen";
                clickable: true;

                MouseArea {
                    anchors.fill: parent;
                    onClicked: () => {
                        screenWindow.state = true;
                    }
                }
            }

            Item {
                Layout.fillWidth: true;
            }

            Pill {
                id: timePill;
                icon: "schedule";
                label: this.hoveredOrClicked ? ClockService.format("dddd, dd yyyy hh:mm:ss") : ClockService.format("hh:mm");
                clickable: true;
            }

            Pill {
                id: volPill;
                icon: VolumeService.icon;
                label: VolumeService.volume.toString() + "%";
                clickable: true;

                MouseArea {
                    anchors.fill: parent;

                    onClicked: (mouse) => {
                        VolumeService.toggleMute();
                    }

                    onWheel: (wheel) => {
                        const d = VolumeService.volume / 100;

                        if (wheel.angleDelta.y > 0) {
                            VolumeService.setVolume(Math.min(1.0, d + 0.02));
                        } else if (wheel.angleDelta.y < 0) {
                            VolumeService.setVolume(Math.max(0.0, d - 0.02));
                        }
                    };
                }
            }

            Item {
                Layout.fillWidth: true;
            }

            SystemTray {
                window: windowAnchor;
            }

            Pill {
                id: notifPill;
                icon: NotifService.isNotEmptyF ? "notifications_unread" : "notifications";
                defaultWidth: -15;
                clickable: true;

                MouseArea {
                    anchors.fill: parent;
                    onClicked: () => {
                        notifWindow.state = true;
                    };
                }
            }
        }
    }
}
