import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import qs
import qs.services

TextField {
    id: root;

    readonly property var theme: ColorGenService.md3;

    property real w: 180;
    property real h: 42;
    property int activeBorder: 2;
    property int inactiveBorder: 1;

    property string fontFamily: Theme.fontFamily;

    property color bg: theme.on_surface;
    property color placeholderColor: theme.surface_variant;
    property color selectionCol: theme.primary;
    property color selectedTextCol: theme.on_primary;

    implicitWidth: w;
    implicitHeight: h;
    
    leftPadding: 14;
    rightPadding: 14;

    font.family: fontFamily;
    font.pixelSize: 14;

    color: bg;
    placeholderTextColor: placeholderColor;
    selectionColor: selectionCol;
    selectedTextColor: selectedTextCol;
    opacity: enabled ? 1.0 : 0.6;

    cursorDelegate: Rectangle {
        visible: root.activeFocus;
        width: 2;
        height: 20;
        radius: 1;
        color: theme.primary;
    }

    background: Rectangle {
        radius: root.h / 2;

        color: root.activeFocus ? theme.surface_container_highest : theme.surface_container;

        border.width: root.activeFocus ? root.activeBorder : root.inactiveBorder;
        border.color: root.activeFocus ? theme.primary : theme.outline_variant;

        Behavior on color {
            ColorAnimation { duration: 250; }
        }

        Behavior on border.color {
            ColorAnimation { duration: 250; }
        }
    }
}
