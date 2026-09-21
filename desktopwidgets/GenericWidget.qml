import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls

import qs
import qs.services
import qs.components.menu
import qs.desktopwidgets.services

Item {
    id: root;
    required property string widgetId;

    readonly property var theme: ColorGenService.md3;

    default property alias content: rect.data;
    property alias menuItems: menu.contentData;

    property var states: ({});

    property color bg: theme.background;
    property color fg: theme.on_background;

    property real r: 10;
    property real w: 200;
    property real h: 200;
    property real posX: 0;
    property real posY: 0;

    property bool shadows: true;
    property real shadowBlur: 10;
    property real shadowSpread: 5;
    property color shadowColor: theme.shadow;

    property color borderColor: theme.outline;
    property real borderWidth: 0;

    signal init();
    signal remove();
    signal unlock(state: bool);

    function setState(obj: var): void {
        WidgetState.saveState(root.widgetId, obj);
    }

    Connections {
        id: conn;
        target: WidgetState;

        property bool ready: Object.keys(WidgetState.stateOf(root.widgetId)).length > 0;

        function onValue(): void {
            root.posX = WidgetState.getX(root.widgetId);
            root.posY = WidgetState.getY(root.widgetId);
            root.states = WidgetState.stateOf(root.widgetId);

            if (!conn.ready) {
                root.init();
                conn.ready = true;                
            }
        }
    }

    StyledMenu {
        id: menu;

        StyledMenuItem {
            menuIcon: "remove";
            text: "Remove Widget";
            onTriggered: {
                root.remove();
                root.visible = false;
            }
        }

        StyledMenuItem {
            menuIcon: drag.enabled ? "lock_open" : "lock";
            text: drag.enabled ? "Lock Position" : "Unlock Position";
            onTriggered: {
                root.unlock(!drag.enabled);
                root.setState({
                        "unlocked": !drag.enabled
                });
                drag.enabled = !drag.enabled;
            }
        }

        StyledSeparator {
            visible: menu.count > 3;
        }
    }

    QsMenuAnchor {
        anchor.window: rect.QsWindow.window;
        id: menuAnchor;
        menu: root.menu;
    }

    Rectangle {
        id: rect;

        color: root.bg;
        radius: root.r;

        x: root.posX;
        y: root.posY;

        implicitWidth: root.w;
        implicitHeight: root.h;

        border.color: root.borderColor;
        border.width: root.borderWidth;

        Behavior on color { ColorAnimation { duration: 250; } }

        DragHandler {
            id: drag;
            enabled: root.states.unlocked;

            onActiveChanged: {
                if (!this.active) {
                    WidgetState.savePosition(
                        root.widgetId,
                        rect.x,
                        rect.y
                    );
                }
            }
        }

        RectangularShadow {
            anchors.fill: rect;
            visible: root.shadows;

            radius: rect.radius;
            blur: root.shadowBlur;
            spread: root.shadowSpread;
            color: root.shadowColor;
            z: -1;

            Behavior on color { ColorAnimation { duration: 250; } }
        }

        MouseArea {
            anchors.fill: parent;

            acceptedButtons: Qt.RightButton;

            onClicked: menu.popup();
        }
    }
}
