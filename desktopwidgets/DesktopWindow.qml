import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects

import qs
import qs.components
import qs.services
import qs.components.menu

import "services";

PanelWindow {
    id: root;

    required property var monitor;
    property var theme: ColorGenService.md3;

    property real centerX: monitor.x + (monitor.width / 2);
    property real centerY: monitor.y + (monitor.height / 2);

    WlrLayershell.layer: WlrLayer.Bottom;

    anchors {
        top: true;
        left: true;
        bottom: true;
        right: true;
    }

    color: "transparent";

    GenericWidget {
        widgetId: "generic";
        posX: centerX;
        posY: centerY;
    }

    GenericWidget {
        id: w;
        widgetId: "second";

        onInit: () => {
            WidgetState.createProps(w.widgetId, {
                    "unlocked": false,
                    "specific-state": false,
                    "third": 120,
                    "year": 2026,
            });
        };

        ColumnLayout {
            anchors.centerIn: parent;

            Text {
                color: w.fg;
                text: "RoShell";

                font.family: Theme.fontFamily;
                font.pixelSize: 48;
                font.weight: Font.Bold;
            }
            Text {
                color: w.fg;
                text: {
                    return w.states.year.toString();
                }

                font.family: Theme.fontFamily;
                font.pixelSize: 12;
                font.weight: Font.Bold;
            }
            Text {
                color: w.fg;
                text: {
                    return w.states.unlocked.toString();
                }

                font.family: Theme.fontFamily;
                font.pixelSize: 16;
                font.weight: Font.Bold;
            }
            Text {
                property int xVal: Math.trunc(WidgetState.getX(w.widgetId));
                property int yVal: Math.trunc(WidgetState.getY(w.widgetId));

                color: w.fg;
                text: {
                    return `${xVal}, ${yVal}`;
                }

                font.family: Theme.fontFamily;
                font.pixelSize: 16;
                font.weight: Font.Bold;
            }
        }
    }
}
