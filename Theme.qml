pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

import qs.services

Singleton {
    id: root;
    property Item get: current;
    property Item current: dracula;

    readonly property string fontFamily: SettingsService.get.font.family;
    readonly property string iconFontFamily: SettingsService.get.font.iconFamily;

    IpcHandler {
        target: "theme";

        function set(name: string): string {
            const n = name.trim().toLowerCase();

            switch (n) {
                case "dracula":
                root.current = dracula;
                break;

                case "mocha":
                root.current = mocha;
                break;

                case "latte":
                root.current = latte;
                break;

                default:
                return `No theme named ${n}`;
            }

            return n;
        }
    }

    Item {
        id: dracula

        readonly property string background: "#282A36";
        readonly property string currentLine: "#6272A4";
        readonly property string selection: "#44475A";
        readonly property string foreground: "#F8F8F2";
        readonly property string comment: "#6272A4";
        readonly property string red: "#FF5555";
        readonly property string orange: "#FFB86C";
        readonly property string yellow: "#F1FA8C";
        readonly property string green: "#50FA7B";
        readonly property string cyan: "#8BE9FD";
        readonly property string purple: "#BD93F9";
        readonly property string pink: "#FF79C6";
    }

    Item {
        id: mocha;

        readonly property string background: "#1E1E2E";
        readonly property string currentLine: "#313244";
        readonly property string selection: "#45475A";
        readonly property string foreground: "#CDD6F4";
        readonly property string comment: "#6C7086";
        readonly property string red: "#F38BA8";
        readonly property string orange: "#FAB387";
        readonly property string yellow: "#F9E2AF";
        readonly property string green: "#A6E3A1";
        readonly property string cyan: "#94E2D5";
        readonly property string purple: "#CBA6F7";
        readonly property string pink: "#F5C2E7";
    }

    Item {
        id: latte;

        readonly property string background: "#EFF1F5";
        readonly property string currentLine: "#E6E9EF";
        readonly property string selection: "#DCE0E8";
        readonly property string foreground: "#4C4F69";
        readonly property string comment: "#8C8FA1";
        readonly property string red: "#D20F39";
        readonly property string orange: "#FE640B";
        readonly property string yellow: "#DF8E1D";
        readonly property string green: "#40A02B";
        readonly property string cyan: "#179299";
        readonly property string purple: "#8839EF";
        readonly property string pink: "#EA76CB";
    }
}
