import Quickshell
import QtQuick
import QtQuick.Layouts

import qs
import qs.components
import qs.services

import "../../utils.js" as Utils;

Item {
    id: root;

    property string source: Qt.resolvedUrl(WallpaperService.current);

    property int c: 4;
    property int r: 2;
    property int s: 2;

    ColorQuantizer {
        id: quantizer;
        source: Qt.resolvedUrl(root.source);
        depth: 3;
        rescaleSize: 64;
    }

    Grid {
        columns: root.c;
        rows: root.r;
        spacing: root.s;

        Repeater {
            model: quantizer.colors;

            HoverableCard {
                bg: modelData;
                w: root.width / 4;
                h: 100;
                clickable: true;

                onClick: {
                    ClipboardService.copy(modelData);
                    tooltip.label = "Copied!";
                    timer.running = true;
                }

                CustomToolTip {
                    id: tooltip;
                    label: modelData;
                    shown: parent.isHovered;
                    backgroundColor: modelData;
                    textColor: Utils.contrastColor(this.backgroundColor);
                }

                Timer {
                    id: timer;
                    interval: 1200;
                    running: false;
                    onTriggered: tooltip.label = modelData;
                }
            }
        }
    }
}
