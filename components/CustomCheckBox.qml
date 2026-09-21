import QtQuick
import QtQuick.Layouts

import qs
import qs.services

Item {
    id: root;

    readonly property var theme: ColorGenService.md3;

    property bool checked: false;
    property color checkedColor: theme.primary_container;
    property color borderColor: theme.outline;
    property color uncheckedColor: "transparent";
    property color checkedThumbColor: theme.on_primary;
    property color uncheckedThumbColor: "#79747E";

    property real switchWidth: 52;
    property real switchHeight: 32;
    property real thumbSize: 24;
    
    signal toggled();

    implicitWidth: switchWidth;
    implicitHeight: switchHeight;

    Rectangle {
        id: box;

        anchors.centerIn: parent;
        width: root.switchWidth;
        height: root.switchHeight;
        radius: height / 2;

        color: root.checked ? root.checkedColor  : root.uncheckedColor;
        border.width: root.checked ? 0 : 2;
        border.color: root.borderColor;

        Behavior on color {
            ColorAnimation { duration: 150; }
        }

        Behavior on width {
            SpringAnimation {
                spring: 3;
                damping: 0.65;
            }
        }

        MouseArea {
            anchors.fill: parent;

            onClicked: () => {
                root.checked = !root.checked;
                root.toggled();
            };
        }

        Rectangle {
            id: thumb;

            width: root.thumbSize;
            height: root.thumbSize;
            radius: width / 2;

            anchors.verticalCenter: parent.verticalCenter;
            x: root.checked ? parent.width - width - 4 : 4;

            color: root.checked ? root.checkedThumbColor : root.uncheckedThumbColor;

            Behavior on x {
                SpringAnimation {
                    spring: 4;
                    damping: 0.65;
                }
            }

            Behavior on width {
                SpringAnimation {
                    spring: 5;
                    damping: 0.7;
                }
            }

            Behavior on height {
                SpringAnimation {
                    spring: 5;
                    damping: 0.7;
                }
            }
        }
    }
}
