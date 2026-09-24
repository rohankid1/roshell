import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import qs
import qs.services
import qs.components
import qs.settings.components

Page {
    id: root;

    name: "Bar";

    readonly property var get: SettingsService.set;
    property var set: SettingsService.set;

    property ListModel barPositions: ListModel {
        ListElement { text: "Top"; value: "top";  }
        ListElement { text: "Bottom"; value: "bottom" }
    };

    ScrollView {
        implicitWidth: root.width;
        implicitHeight: root.height - 120;

        ColumnLayout {
            TapHandler {
                onTapped: parent.forceActiveFocus();
            }

            Option {
                w: root.width;

                name: "Position";
                description: "Position the bar at the top or the bottom";
                icon: "position_bottom_right";

                StyledComboBox {
                    model: barPositions;
                    textRole: "text";
                    valueRole: "value";
                    currentValue: {
                        const pos = get.shell.bar.position.trim().toLowerCase();
                        if (pos !== "top" && pos !== "bottom") {
                            return "top";
                        }

                        return pos;
                    }
                    onActivated: set.shell.bar.position = this.currentValue;
                }
            }
        }
    }
}
