pragma Singleton

import Quickshell
import Quickshell.Io
import Quickshell.Services.Notifications
import QtQuick

import qs
import qs.services
import "../../utils.js" as Utils

Singleton {
    id: root;

    property bool dnd: SettingsService.get.notifications.dnd;

    property list<var> list: [];
    property bool isEmpty: list.length === 0;
    property bool isNotEmpty: list.length > 0;

    property list<var> filteredList: list.filter(n => n.notification !== null);
    property bool isEmptyF: filteredList.length === 0;
    property bool isNotEmptyF: filteredList.length > 0;

    property int _internalCounter: 0;

    Component.onCompleted: {
        Utils.initService("NotifService");
    }

    function toggleDnd(): void {
        SettingsService.set.notifications.dnd = !SettingsService.get.notifications.dnd;
    }

    function dismissAll(): void {
        const remove = [...root.list];
        root.list = [];

        for (const n of remove) {
            if (n.notification) n.dismiss();
        }
    }

    function dismiss(notif): void {
        if (notif) notif.dismiss();
    }

    function addNotification(newNotif): void {
        // list = [newNotif, ...list];
    }

    component Notif: QtObject {
        id: notif;

        property Notification notification: null;
        property string cId: "";
        property int notifId: -1;
        property string appName: "";
        property string appIcon: "";
        property string summary: "";
        property string body: "";
        property string image: "";
        property int urgency: NotificationUrgency.Normal;
        property var actions: [];

        Component.onCompleted: {
            if (!notif.notification) return;

            notifId = notification.id;
            appName = notification.appName || "";
            appIcon = notification.appIcon || "";
            summary = notification.summary || "";
            body = notification.body || "";
            image = notification.image || "";
            urgency = notification.urgency;
            actions = notification.actions;
        }

        function isEmpty() {
            return !appName && !summary && !body && !image;
        }

        function dismiss(): void {
            if (notification) {
                notification.dismiss();
            }
        }
    }

    Component {
        id: notifComp;

        Notif {}
    }

    Process {
        id: soundProc;
        command: ["pw-play", "/usr/share/sounds/ocean/stereo/message-new-instant.oga"];
        running: false;
    }

    NotificationServer {
        id: server;

        imageSupported: true;
        bodySupported: true;
        bodyMarkupSupported: true;
        bodyImagesSupported: true;
        keepOnReload: true;

        onNotification: (n) => {
            if (!n) return;

            n.tracked = true;

            if (!root.dnd)
            soundProc.running = true;

            const data = notifComp.createObject(root, {
                    cId: String(root._internalCounter++),
                    notification: n
            });

            root.list = [data, ...root.list];
        };
    }

    IpcHandler {
        target: "ns";

        function clearAll(): void {
            root.dismissAll();
        }
    }
}
