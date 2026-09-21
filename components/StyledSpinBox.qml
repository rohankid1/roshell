import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import qs
import qs.services

SpinBox {
    id: root;

    property var theme: ColorGenService.md3;

    property color bg: theme.surface_container_highest;
    property color fg: theme.on_surface;
    property color hoverColor: theme.surface_container_high;
    property color accentColor: theme.primary;

    property real w: 100;
    property real h: 40;

    implicitWidth: w;
    implicitHeight: h;

    from: 0;
    to: 32;
    stepSize: 1;

    background: Rectangle {
        radius: root.h / 2;
        color: root.hovered ? root.hoverColor : root.bg;
    }

    contentItem: TextInput {
        text: root.textFromValue(root.value, root.locale);

        color: root.fg;

        font.family: Theme.fontFamily;
        font.pixelSize: 14;

        horizontalAlignment: Text.AlignHCenter;
        verticalAlignment: Text.AlignVCenter;

        selectByMouse: true;

        onTextEdited: {
            root.value = root.valueFromText(text, root.locale);
        }
    }

    up.indicator: Rectangle {
        implicitWidth: 32;
        implicitHeight: root.height / 2;

        x: root.width - width - 2;
        y: 2;

        color: "transparent";

        Text {
            anchors.centerIn: parent;
            text: "keyboard_arrow_up";
            color: root.fg;

            font.family: Theme.iconFontFamily;
            font.pixelSize: 18;
        }

        MouseArea {
            anchors.fill: parent;
            onClicked: root.increase();
        }
    }

    down.indicator: Rectangle {
        implicitWidth: 32;
        implicitHeight: (root.height - 4) / 2;

        x: root.width - width - 2;
        y: root.height / 2;

        color: "transparent";

        Text {
            anchors.centerIn: parent;
            text: "keyboard_arrow_down";
            color: root.fg;

            font.family: Theme.iconFontFamily;
            font.pixelSize: 18;
        }

        MouseArea {
            anchors.fill: parent;
            onClicked: root.decrease();
        }
    }
}
