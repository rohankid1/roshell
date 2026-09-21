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
    name: "Color";
    description: "Configuration for color generation";

    property var set: SettingsService.set;
    property var get: SettingsService.get;

    property ListModel schemes: ListModel {
        ListElement { text: "Expressive"; value: "scheme-expressive"; }
        ListElement { text: "Content"; value: "scheme-content"; }
        ListElement { text: "Fidelity"; value: "scheme-fidelity"; }
        ListElement { text: "Fruit Salad"; value: "scheme-fruit-salad"; }
        ListElement { text: "Monochrome"; value: "scheme-monochrome"; }
        ListElement { text: "Neutral"; value: "scheme-neutral"; }
        ListElement { text: "Rainbow"; value: "scheme-rainbow"; }
        ListElement { text: "Tonal Spot"; value: "scheme-tonal-spot"; }
        ListElement { text: "Vibrant"; value: "scheme-vibrant"; }
        ListElement { text: "Smart"; value: "scheme-smart"; }
    };

    property ListModel modes: ListModel {
        ListElement { text: "Smart"; value: "smart"; }
        ListElement { text: "Dark"; value: "dark"; }
        ListElement { text: "Light"; value: "light" }
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

                icon: "cleaning_services";
                name: "Provider";
                description: "Service that provides color generation";

                StyledComboBox {
                    enabled: false;
                    model: ["Matugen", "Iris"]
                }
            }

            Spacer {}

            Option {
                w: root.width;

                icon: "palette";
                name: "Scheme Type";
                description: "Dictates how colors are extracted";

                StyledComboBox {
                    model: schemes;
                    textRole: "text";
                    valueRole: "value";
                    currentValue: root.get.wallpaper.colorGen.matugen.schemeType;
                    onActivated: root.set.wallpaper.colorGen.matugen.schemeType = this.currentValue;
                }
            }

            Option {
                w: root.width;

                icon: "mode_night";
                name: "Mode";
                description: "Whether the generated colours should be dark, light, or automatic based on extracted colors";

                StyledComboBox {
                    model: modes;
                    textRole: "text";
                    valueRole: "value";
                    currentValue: root.get.wallpaper.colorGen.matugen.mode;
                    onActivated: root.set.wallpaper.colorGen.matugen.mode = this.currentValue;
                }
            }

            Spacer {}

            Option {
                w: root.width;

                icon: "contrast";
                name: "Contrast";
                description: "Adjusts the luminance/brightness of elements (default 0)";

                StyledSpinBox {
                    from: -1;
                    to: 1;
                    value: root.get.wallpaper.colorGen.matugen.contrast;

                    onValueChanged: root.set.wallpaper.colorGen.matugen.contrast = this.value;
                }
            }
        }
    }
}
