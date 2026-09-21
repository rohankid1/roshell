import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import qs
import qs.services

MenuItem {
    id: root;

    property var theme: ColorGenService.md3;

    property string menuIcon: "";

    property color iconColor: theme.on_surface_variant;
    property color textColor: theme.on_surface_variant;
    property color hoverColor: theme.surface_container_highest;

    implicitHeight: 48;

    HoverHandler {
        id: hover;
    }

    contentItem: Row {
        spacing: 12;

        Text {
            anchors.verticalCenter: parent.verticalCenter;
            visible:  root.menuIcon !== "";

            text: root.menuIcon;
            color: root.textColor;

            font.family: Theme.iconFontFamily;
            font.pixelSize: 20;

            width: 24;
        }

        Text {
            anchors.verticalCenter: parent.verticalCenter;
            verticalAlignment: Text.AlignVCenter;
            
            text: root.text;
            color: root.textColor;

            font.family: Theme.fontFamily;
            font.pixelSize: 14;
        }
    }

    background: Rectangle {
        anchors {
            fill: parent;
            margins: 4;
        }
        
        radius: 12;

        color: hover.hovered ? root.hoverColor : "transparent";
    }
}
