import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import qs
import qs.services

Button {
    id: root;

    property var theme: ColorGenService.md3;

    property color buttonColor: theme.surface_container;
    property color hoverColor: theme.surface_container_high;
    property color pressedColor: theme.surface_container_highest;

    property color textColor: theme.on_surface;
    property color hoverTextColor: theme.on_surface;
    property color pressedTextColor: theme.on_surface;

    property color borderColor: "transparent";
    property color hoverBorderColor: borderColor;
    property color pressedBorderColor: borderColor;

    property real buttonRadius: height / 2;
    property real borderWidth: 0;

    property string fontFamily: Theme.fontFamily;
    property real fontSize: 14;
    property int fontWeight: Font.Medium;

    property string btnIcon: "";
    property string iconFontFamily: Theme.iconFontFamily;
    property real iconSize: 18;
    property real iconSpacing: 6;

    scale: root.down ? 0.96 : root.hovered ? 1.03 : 1.0;

    Behavior on scale {
        SpringAnimation {
            mass: 1;
            damping: 7;
            spring: 5;
        }
    }

    contentItem: RowLayout {
        spacing: root.btnIcon !== "" ? root.iconSpacing : 0;

        Text {
            Layout.alignment: root.text === "" ? Qt.AlignCenter : Qt.AlignVCenter | Qt.AlignLeft;

            visible: root.btnIcon !== "";
            text: root.btnIcon;
            color: root.down ? root.pressedTextColor :
            root.hovered ? root.hoverTextColor : root.textColor;

            font.family: root.iconFontFamily;
            font.pixelSize: root.iconSize;
        }

        Text {
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter;
            
            text: root.text;
            color: root.down ? root.pressedTextColor :
            root.hovered ? root.hoverTextColor : root.textColor;
            font.family: root.fontFamily;
            font.pixelSize: root.fontSize;
            font.weight: root.fontWeight;

            horizontalAlignment: Text.AlignHCenter;
            verticalAlignment: Text.AlignVCenter;
        }
    }

    background: Rectangle {
        radius: root.buttonRadius;

        color: root.down ? root.pressedColor :
        root.hovered ? root.hoverColor : root.buttonColor;

        border.width: root.borderWidth;

        border.color: root.down ? root.pressedBorderColor :
        root.hovered ? root.hoverBorderColor : root.borderColor;

        Behavior on color { ColorAnimation { duration: 250; } }
        Behavior on border.color { ColorAnimation { duration: 250; } }
    }
}
