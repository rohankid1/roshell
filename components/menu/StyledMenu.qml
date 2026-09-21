import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import qs
import qs.services

Menu {
    id: root;

    readonly property var theme: ColorGenService.md3;

    property color menuColor: theme.surface_container;
    property color borderColor: theme.outline_variant;

    implicitWidth: 220;

    background: Rectangle {
        implicitWidth: 220;
        color: root.menuColor;
        radius: 16;

        border.width: 1;
        border.color: root.borderColor;
    }
}
