import QtQuick
import QtQuick.Controls

import qs
import qs.services

ToolTip {
    id: root;
    readonly property var theme: ColorGenService.md3;
    property color backgroundColor: theme.bg;
    property color textColor: theme.fg;    
    property color borderColor: theme.outline;
    property string label: "";
    property bool shown: false;
    
    text: label;
    visible: shown;
    opacity: this.visible ? 1.0 : 0.0;
    width: this.visible ? implicitWidth : 0.0;
    contentItem: Text {
        text: label;
        color: root.textColor;
    }
    background: Rectangle {
        color: root.backgroundColor;
        border.color: root.borderColor;
        radius: 8;
    }

    Behavior on opacity {
        NumberAnimation { duration: 200; }
    }

    Behavior on width {
        NumberAnimation { duration: 250; }
    }
}
