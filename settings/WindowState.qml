pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root;

    Component.onCompleted: {
        console.log("WindowState");
    }

    signal page(newPage: string);

    readonly property string general: "pages/GeneralPage.qml";
    readonly property string wallpaper: "pages/WallpaperPage.qml";
    readonly property string color: "pages/ColorPage.qml";

    readonly property bool isOnGeneral: activeTab === general;
    readonly property bool isOnWallpaper: activeTab === wallpaper;
    readonly property bool isOnColor: activeTab === color;

    function setPage(newPage: string) {
        const a = [general, wallpaper, color];

        if (a.some(i => i === newPage)) {
            if (activeTab === newPage) return;
            
            activeTab = newPage;
            page(newPage);
        }
    }

    property string activeTab: general;
}
