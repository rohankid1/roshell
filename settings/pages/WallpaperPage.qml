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
    name: "Wallpaper";
    description: "Configuration for Awww";

    property var get: SettingsService.get;
    property var set: SettingsService.set;

    ScrollView {
        implicitWidth: root.width;
        implicitHeight: root.height - 120;

        TapHandler {
            onTapped: parent.forceActiveFocus();
        }

        ColumnLayout {
            id: content;

            Option {
                w: root.width;

                name: "Source";
                description: "Path where wallpapers should be fetched";
                icon: "wallpaper";

                StyledTextField {
                    text: root.get.wallpaper.directoryPath;
                    onEditingFinished: root.set.wallpaper.directoryPath = this.text;
                }
            }

            Option {
                w: root.width;

                name: "Current Wallpaper";
                description: WallpaperService.current;
                icon: "folder";

                StyledButton {
                    implicitWidth: 100;
                    implicitHeight: 40;

                    borderColor: theme.outline_variant;
                    borderWidth: 1;

                    text: "Reapply";

                    onClicked: WallpaperService.setWp(WallpaperService.current);
                }
            }

            Spacer {}
           
            ColorGrid {
                Layout.fillWidth: true;
                Layout.preferredHeight: 250;
                
                source: WallpaperService.current;
            }

            Spacer {}

            Option {
                w: root.width;

                name: "Transition FPS";
                description: "Frame rate for the wallpaper transition (default 30)";
                icon: "30fps";

                StyledSpinBox {
                    from: 30;
                    to: 200;
                    editable: true;
                    value: root.get.wallpaper.awww.transitionFps;

                    onValueChanged: {
                        root.set.wallpaper.awww.transitionFps = this.value;
                    }
                }
            }

            Option {
                w: root.width;

                name: "Transition Duration";
                description: "How long it takes for the animation to complete in seconds (default 3)";
                icon: "timer";

                StyledSpinBox {
                    from: 1;
                    to: 1000;
                    editable: true;
                    value: root.get.wallpaper.awww.transitionDuration;

                    onValueChanged: {
                        root.set.wallpaper.awww.transitionDuration = this.value;
                    }
                }
            }

            Option {
                w: root.width;

                name: "Transition Angle";
                description: "Controls the angle of the wipe (default 45)";
                icon: "animation";

                StyledSpinBox {
                    from: 0;
                    to: 360;
                    editable: true;
                    value: root.get.wallpaper.awww.transitionAngle;

                    onValueChanged: {
                        root.set.wallpaper.awww.transitionAngle = this.value;
                    }
                }
            }

            Option {
                w: root.width;

                name: "Transition Step";
                description: "How fast the transition reaches the new image (default 90)";
                icon: "step";

                StyledSpinBox {
                    from: 1;
                    to: 255;
                    editable: true;
                    value: root.get.wallpaper.awww.transitionStep;

                    onValueChanged: {
                        root.set.wallpaper.awww.transitionStep = this.value;
                    }
                }
            }
        }
    }
}
