pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root;

    readonly property string wpPath: SettingsService.get.wallpaper.directoryPath;
    property list<string> wallpapers: [];
    property list<string> filteredWallpapers: wallpapers;
    property string current: "";

    Component.onCompleted: {
        console.log("init: WallpaperService");
    }

    onWpPathChanged: {
        root.reload();
    }

    IpcHandler {
        target: "wps";
        
        function current(): void {
            return root.current;
        }

        function reload(): void {
            root.wallpapers = [];
            root.fetchWpsProcess = true;
        }

        function set(imagePath: string): void {
            root.setWp(imagePath);
        }
    }

    Process {
        id: currentWpProcess;
        command: ["bash", "-c", "awww query --json | jq '.\"\"[0].displaying.image'"];
        stdout: StdioCollector {
            onStreamFinished: {
                const text = this.text.replace(/\"/g, "").trim();
                root.current = text;
            }
        }
        running: true;
    }

    Process {
        id: fetchWpsProcess;
        running: true;
        command: ["find", root.wpPath, "-type", "f",
              "(", "-iname", "*.png", "-o", "-iname", "*.jpg",
              "-o", "-iname", "*.jpeg", "-o", "-iname", "*.webp", ")"];
        stdout: StdioCollector {
            onStreamFinished: {
                const split = this.text.split("\n");
                root.wallpapers = [...split];
            }
        }
    }

    Process {
        id: setWpProcess;
        command: [];
        running: false;
    }

    function reload(): void {
        wallpapers = [];
        fetchWpsProcess.running = true;
    }

    function reloadCurrentWp(): void {
        currentWpProcess.running = true;
    }

    function prepareProcess(img: string) {
        const s = SettingsService.get.wallpaper.awww;
        const fps = s.transitionFps;
        const duration = s.transitionDuration;
        const angle = s.transitionAngle;
        const step = s.transitionStep;
        const ttype = s.transitionType;
        const tpos = s.transitionPos;

        setWpProcess.command = [
            "awww",
            "img", img,
            "--transition-type", ttype,
            "--transition-pos", tpos,
            "--transition-duration", duration,
            "--transition-fps", fps
        ];
    }

    function setWp(path: string): void {
        current = path;

        prepareProcess(path);

        setWpProcess.running = true;
        currentWpProcess.running = true;

        ColorGenService.generate(path);
    }

    function setFilter(text: string): void {
        if (text.trim() === "") filteredWallpapers = wallpapers;

        filteredWallpapers = wallpapers.filter((item) => {
            return item.toLowerCase().includes(text.toLowerCase());
        });
    }
}
