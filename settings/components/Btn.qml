import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import qs
import qs.services

Rectangle {
    id: root;

    enum Show {
        Both = 0,
        IconOnly = 1,
        TextOnly = 2
    }

    readonly property var theme: ColorGenService.md3;
    readonly property bool isBoth: display === Btn.Show.Both;
    readonly property bool isIconOnly: display === Btn.Show.IconOnly;
    readonly property bool isTextOnly: display === Btn.Show.TextOnly;

    property real w: 150;
    property real h: 50;
    property real r: Math.min(h / 2, 25);
    
    property string label: "";
    property string icon: "";
    property string fontFamily: Theme.fontFamily;
    property string iconFontFamily: Theme.iconFontFamily;

    property color buttonColor: theme.primary;
    property color textColor: theme.on_primary;
    property color borderColor: theme.outline;

    readonly property bool shouldShowIcon: root.isBoth || root.isIconOnly;
    readonly property bool shouldShowText: root.isBoth || root.isTextOnly;

    property int display: Btn.Show.Both;

    signal click();

    color: ha.hovered ? Qt.lighter(buttonColor, 1.7) : buttonColor;
    border.color: borderColor;
    radius: r;
    implicitWidth: w;
    implicitHeight: h;

    Behavior on color {
        ColorAnimation { duration: 250; }
    }

    MouseArea {
        id: ma;
        anchors.fill: parent;
        onClicked: root.click();
    }

    HoverHandler {
        id: ha;
    }

    RowLayout {
        anchors.fill: parent;

        Text {
            Layout.alignment: Qt.AlignCenter;
            
            text: root.icon;
            color: root.textColor;
            visible: root.shouldShowIcon;

            font.weight: Font.Bold;
            font.pixelSize: root.shouldShowIcon ? 24 : 16;
            font.family: root.iconFontFamily;
        }

        Text {
            Layout.alignment: Qt.AlignCenter;
            
            text: root.label;
            color: root.textColor;
            visible: root.shouldShowText;

            font.weight: root.isTextOnly ? Font.Bold : Font.Normal;
            font.family: root.fontFamily;
        }
    }
}
