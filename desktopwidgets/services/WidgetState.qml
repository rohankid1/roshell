pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

import "../../utils.js" as Utils;

Singleton {
    id: root;

    property alias positions: adapter.positions;
    property alias states: adapter.states;

    signal value();

    Component.onCompleted: {
        Utils.initService("WidgetState");
    }

    function savePosition(widgetId: string, newX: real, newY: real): void {
        let updated = Object.assign({}, root.positions);

        updated[widgetId] = {
            "x": newX,
            "y": newY,
        };

        adapter.positions = updated;

        fileview.writeAdapter();
    }

    function saveState(widgetId: string, state: var): void {
        let updated = Object.assign({}, root.states);

        updated[widgetId] = Object.assign(
            {},
            root.states[widgetId] ?? {},
            state
        );

        adapter.states = updated;

        fileview.writeAdapter();
    }

    function getX(widgetId: string): real {
        const fallback = 0;
        const widget = root.positions[widgetId];

        if (!widget) return fallback;

        return widget.x ?? fallback;
    }

    function getY(widgetId: string): real {
        const fallback = 0;
        const widget = root.positions[widgetId];

        if (!widget) return fallback;

        return widget.y ?? fallback;
    }

    function stateOf(widgetId: string): var {
        return root.states[widgetId] ?? {};
    }

    function createProps(widgetId, props: var): void {
        if (root.states[widgetId] !== undefined) return;

        let updated = Object.assign({}, root.states);
        updated[widgetId] = props;

        adapter.states = updated;
        fileview.writeAdapter();
    }

    FileView {
        id: fileview;
        path: Quickshell.dataPath("state.json");
        watchChanges: true;
        onFileChanged: {
            root.value();
            this.reload();
        }
        onLoaded: root.value();

        adapter: JsonAdapter {
            id: adapter;

            property var positions: ({});
            property var states: ({});
        }
    }
}
