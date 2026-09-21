import QtQuick

import qs
import qs.services
import qs.components

Rectangle {
    readonly property var theme: ColorGenService.md3;
    
    property int w: 64;
    property int h: 64;
    property int borderRadius;
    property color background: theme.background;
    property bool shown: false;
    property alias trackColor: progress.trackColor;
    property alias spinnerColor: progress.spinnerColor;
    

    implicitWidth: w;
    implicitHeight: h;
    color: background;                       
    visible: shown;
    radius: borderRadius;

    CircularProgress {
        id: progress;
        anchors.centerIn: parent;
        size: Math.min(parent.width, parent.height) * 0.5;
    }    
}
