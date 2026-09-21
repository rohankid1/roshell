import Quickshell
import QtQuick
import QtQuick.Layouts

import qs
import qs.services
import qs.settings

Rectangle {
    id: root;

    readonly property var theme: ColorGenService.md3;

    property color bg: theme.surface_container_high;
    property color fg: theme.on_surface;
    property color borderColor: theme.outline;

    property real w: parent.width;
    property real h: 60;
    property real r: h / 2;

    property string fontFamily: Theme.fontFamily;
    property string iconFontFamily: Theme.iconFontFamily;
    property string name: "";
    property string description: "";
    property string icon: "";
    default property alias content: content.data;

    implicitWidth: w;
    implicitHeight: h;

    color: bg;
    radius: h;

    RowLayout {
        anchors.fill: parent;
        anchors.margins: 10;
        spacing: 20;

        Item { 
            Layout.preferredWidth: 40;
            Layout.minimumWidth: 40;
            Layout.maximumWidth: 40;
            Layout.fillHeight: true;

            Text {
                anchors.centerIn: parent;

                text: root.icon;
                color: root.fg;

                font.family: root.iconFontFamily;
                font.pixelSize: 32;
            }
        }

        ColumnLayout {
            Layout.fillWidth: true;
            Layout.alignment: Qt.AlignLeft;
            
            Text {
                Layout.fillWidth: true;
                
                text: root.name;
                color: root.fg;

                font.weight: Font.Bold;
                font.family: Theme.fontFamily;
                font.pixelSize: 14;
            }

            Text {
                Layout.fillWidth: true;
                
                text: root.description;
                color: root.fg;

                font.family: Theme.fontFamily;
                font.pixelSize: 10;
            }
        }

        RowLayout {
            // this is the far right
            id: content;

            Layout.alignment: Qt.AlignVCenter;
            Layout.minimumWidth: 0;
            spacing: 0;
        }
    }
}
