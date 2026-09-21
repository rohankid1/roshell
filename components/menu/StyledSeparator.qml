import QtQuick
import QtQuick.Controls

import qs
import qs.services

MenuSeparator {
    id: root;

    readonly property var theme: ColorGenService.md3;

    property real h: 1;
    property color sepColor: theme.outline_variant;

    contentItem: Rectangle {
        anchors {
            left: parent.left;
            right: parent.right;
            margins: 16;
        }
        
        implicitHeight: root.h;
        color: root.sepColor;
    }
}
