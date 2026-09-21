pragma Singleton

import Quickshell
import Quickshell.Services.Pipewire
import QtQuick

import "../utils.js" as Utils

Singleton {
    id: root;

    readonly property var sink: Pipewire.defaultAudioSink;
    readonly property var source: Pipewire.defaultAudioSource;
    readonly property bool ready: sink && sink.ready;
    readonly property bool muted: ready && sink.audio.muted;
    readonly property int volume: ready ? Math.round(sink.audio.volume * 100) : 0;
    readonly property string icon: {
        if (!ready || volume <= 0 || muted) return "volume_off";

        if (volume < 30) return "volume_down";

        return "volume_up";
    }

    Component.onCompleted: {
        Utils.initService("VolumeService");
    }

    PwObjectTracker {
        objects: [sink, source];
    }

    function setVolume(val: real): void {
        if (ready) {
            sink.audio.muted = false;
            sink.audio.volume = val;
        }
    }

    function toggleMute(): void {
        if (ready) {
            sink.audio.muted = !sink.audio.muted;
        }
    }
}
