pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

import "../utils.js" as Utils

Singleton {
    id: root;

    readonly property string clipboardText: Quickshell.clipboardText;

    function copy(text: string): void {
        copierProc.command = ["wl-copy", text];
        copierProc.running = true;
    }

    Component.onCompleted: {
        Utils.initService("ClipboardService");
    }

    Process {
        id: copierProc;
        running: false;
    }
}
