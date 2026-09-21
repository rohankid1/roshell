pragma Singleton

import Quickshell
import QtQuick

import "../utils.js" as Utils

Singleton {
    id: root;

    Component.onCompleted: {
        Utils.initService("ClockService");
    }

    SystemClock {
        id: clock;
        precision: SystemClock.Seconds;
    }

    function format(fmt: string): string {
        return Qt.formatDateTime(clock.date, fmt);
    }
}
