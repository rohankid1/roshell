pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

import qs.desktopwidgets.services

import "../utils.js" as Utils

Singleton {
    id: root;

    readonly property alias get: jsonAdapter;
    property alias set: jsonAdapter;

    readonly property string homePath: Quickshell.env("HOME");
    readonly property string picturesPath: homePath + "/Pictures";

    Component.onCompleted: {
        Utils.initService("SettingsService");
        console.log("Writing configuration to: " + Quickshell.dataDir)
        console.log(WidgetState.states);
    }

    FileView {
        id: fileView;
        path: Quickshell.dataPath("settings.json");
        blockLoading: true;
        watchChanges: true;

        onFileChanged: this.reload();
        onAdapterUpdated: this.writeAdapter();

        adapter: JsonAdapter {
            id: jsonAdapter;

            property JsonObject notifications: JsonObject {
                property bool dnd: false;
            };

            property JsonObject wallpaper: JsonObject {
                property string directoryPath: root.picturesPath + "/wallpapers";

                property JsonObject awww: JsonObject {
                  property int transitionFps: 30;
                  property int transitionDuration: 3;
                  property int transitionAngle: 45;
                  property int transitionStep: 90;

                  property string transitionType: "random";  
                  property string transitionPos: "center";
                };

                property JsonObject colorGen: JsonObject {
                    property string backend: "matugen";
                    property bool dark: true;

                    property JsonObject matugen: JsonObject {
                        property string schemeType: "scheme-expressive";
                        property string mode: "smart";

                        property real contrast: 0.0;
                        property real opacity: 1.0;
                        property real lightnessDark: 0;
                        property real lightnessLight: 0;
                    };
                }
            };

            property JsonObject font: JsonObject {
                property string family: "Poppins";
                property string iconFamily: "Material Symbols Rounded";
            };

            property JsonObject general: JsonObject {
                property int borderRadius: 10;

                property JsonObject animations: JsonObject {
                    property int colorAnimDuration: 250;
                    property int borderColorAnimDuration: 250;
                };
            };

            property JsonObject shell: JsonObject {
                property JsonObject bar: JsonObject {
                    property string position: "top";
                    property bool vertical: false;

                    property JsonObject workspaces: JsonObject {
                        property bool automaticallyResize: true;
                        property int maxStaticWorkspaces: 5;
                    };

                    property JsonObject clock: JsonObject {
                        property string format: "";
                    }
                };
            };
        }
    }
}
