import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import qs
import qs.components
import qs.services
import qs.notifications
import qs.notifications.services

Popup {
    id: root;

    required property var w;

    readonly property var theme: ColorGenService.md3;

    property color foreground: theme.on_background;
    property color secondaryBg: theme.surface_container;

    property string fontFamily: Theme.fontFamily;


    window: w;
    title: "Notifications";
    popupWidth: 500;
    popupHeight: 500;

    IpcHandler {
        target: "notif";

        function toggleWindow(): void {
            root.state = !root.state;
        }
    }

    ColumnLayout {
        anchors.fill: parent;
        spacing: 10;

        Rectangle {
            Layout.fillWidth: true;
            Layout.fillHeight: true;

            id: rect;
            color: root.secondaryBg;
            radius: 20;

            ListView {
                id: listView;
                anchors.fill: parent;
                anchors.margins: 10;

                model: ScriptModel { values: NotifService.list.filter(n => n.notification !== null); objectProp: "cId"; }
                clip: true;
                spacing: 5;

                delegate: NotificationCard {
                    n: modelData;
                    w: parent.width;
                }

                add: Transition {
                    ParallelAnimation {
                        RotationAnimation {
                            from: 360;
                            to: 0;
                            duration: 500;
                        }

                        NumberAnimation {
                            property: "scale";
                            from: 0;
                            to: 1.0;
                            duration: 500;
                        }
                    }
                }

                remove: Transition {
                    SequentialAnimation {
                        NumberAnimation {
                            property: "scale";
                            from: 1.0;
                            to: 0.6;
                            duration: 300;
                        }

                        NumberAnimation {
                            property: "x";
                            from: 0;
                            to: -listView.width;
                            duration: 300;
                        }
                    }
                }

                displaced: Transition {
                    NumberAnimation {
                        properties: "x,y";
                        easing.type: Easing.OutQuad;
                        duration: 400;
                    }
                }
            }
        }

        RowLayout {
            Btn {
                Layout.alignment: Qt.AlignBottom;
                Layout.fillWidth: true;
                Layout.preferredHeight: 32;

                label: "Dismiss All";
                enabled: NotifService.isNotEmptyF;
                onClick: () => {
                    NotifService.dismissAll();
                };
            }

            ColumnLayout {
                Text {
                    Layout.alignment: Qt.AlignHCenter;

                    text: "DND";
                    font.family: root.fontFamily;
                    color: root.foreground;
                }

                CustomCheckBox {
                    checked: NotifService.dnd;
                    onToggled: {
                        NotifService.toggleDnd();
                    }
                }
            }
        }

    }
}
