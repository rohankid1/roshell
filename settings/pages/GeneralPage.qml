import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import qs
import qs.services
import qs.components
import qs.settings.components

Page {
    id: root;

    name: "General";
    description: "Basic configuration settings for RoShell";

    property var getGeneral: SettingsService.get;
    property var setGeneral: SettingsService.set;

    TapHandler {
        onTapped: parent.forceActiveFocus();
    }

    ColumnLayout {
        Option {
            w: root.width;

            name: "Border Radius";
            description: "Increase or decrease border radius";
            icon: "rounded_corner";

            StyledSpinBox {
                id: optBorderRadius;
                from: 0;
                to: 100;
                editable: true;
                value: getGeneral.general.borderRadius;

                onValueChanged: {
                    setGeneral.general.borderRadius = this.value;
                }
            }
        }

        Option {
            w: root.width;

            name: "Font Family";
            description: "Text style. Default: 'Poppins'"
            icon: "font_download";

            StyledTextField {
                placeholderText: "Poppins";
                text: getGeneral.font.family;
                onEditingFinished: setGeneral.font.family = this.text;
            }
        }

        Option {
            w: root.width;

            name: "Icon Font Family";
            description: "The font for the icons (volume icons, clock, etc). Default: 'Material Symbols Rounded'"
            icon: "gallery_thumbnail";

            StyledTextField {
                placeholderText: "Material Symbols Rounded";
                text: getGeneral.font.iconFamily;
                onEditingFinished: setGeneral.font.iconFamily = this.text;
            }
        }
    }
}
