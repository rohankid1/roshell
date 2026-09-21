import Quickshell
import QtQuick
import QtQuick.Layouts

import qs
import qs.services

Item {
    id: root;

    readonly property var theme: ColorGenService.md3;

    default property alias content: item.data;

    property string name: "";
    property string description: "";
    property string fontFamily: Theme.fontFamily;

    property color textColor: theme.on_background;

    ColumnLayout {
        anchors.fill: parent;

        Text {
            text: root.name;
            color: root.textColor;

            font.family: root.fontFamily;
            font.pixelSize: 32;
        }

        Text {
            Layout.fillWidth: true;
            
            text: root.description;
            font.family: root.fontFamily;
            color: root.textColor;

            wrapMode: Text.Wrap;
        }

        Item {
            id: item;

            Layout.topMargin: 20;
            Layout.fillWidth: true;
            Layout.fillHeight: true;
        }
    }
}
